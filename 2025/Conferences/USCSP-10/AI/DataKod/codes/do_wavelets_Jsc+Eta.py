import os
import numpy as np
import matplotlib.pyplot as plt
import pywt
import pandas as pd

# Генерація унікальних комбінацій для словника
def generate_folder_dict(df):
    folder_dict = {}

    for index, row in df.iterrows():
        # Отримуємо значення стобців 'N_B', 'T' и 'd' у вигляді рядків
        N_B_value = row['N_B']
        T_value = row['T'] 
        d_value = float(row['d']) / (10 ** -6)  
        # Форматуєм N_B
        N_B_str = "{:.3e}".format(N_B_value).replace('+', '')  
        N_B_formatted = N_B_str.replace('.', 'p')  

        # Форматуєм назву папки
        folder_name = "B{}T{}D{:0.0f}_data".format(N_B_formatted, int(T_value), d_value)

        # Додаємо до словника
        folder_dict[folder_name] = (N_B_value, T_value, row['d'])

    return folder_dict

def create_files(folder_dict, result_file_path):
    for folder_name, values in folder_dict.items():
        os.makedirs(folder_name, exist_ok=True)

        N_B_value, T_value, d_value = values

        df_result = pd.read_csv(result_file_path, sep=' ')

        filtered_df = df_result[(df_result['N_B'] == N_B_value) & 
                                (df_result['T'] == T_value) & 
                                (df_result['d'] == d_value)]

        # Отримуємо унікальні значення N_Fe
        unique_N_Fe = filtered_df['N_Fe'].unique()

        for N_Fe_value in unique_N_Fe:
            # експоненційна форма
            N_Fe_exp = "{:.3E}".format(N_Fe_value)

            # Створення файлів Jsc и Eta
            file_name_jsc = f"Jsc{N_Fe_exp}.dat"
            file_name_eta = f"Eta{N_Fe_exp}.dat"

            file_path_jsc = os.path.join(folder_name, file_name_jsc)
            file_path_eta = os.path.join(folder_name, file_name_eta)

            # фільтр рядків для певного N_Fe
            filtered_df_N_Fe = filtered_df[filtered_df['N_Fe'] == N_Fe_value]

            # Запис у файли Jsc и Eta
            for file_path, column_name in zip([file_path_jsc, file_path_eta], ['Jsc', 'Eta']):
                with open(file_path, 'w') as f:
                    for index, row in filtered_df_N_Fe[['Time', column_name]].iterrows():
                        if not pd.isna(row['Time']) and not pd.isna(row[column_name]):
                            value = float(row[column_name])
                            f.write(f"{int(row['Time'])} {value:.5f}\n")

    return "Files created successfully."

def normalize_files(folder_dict):
    for folder_name in folder_dict.keys():
        files = os.listdir(folder_name)

        for file_name in files:
            if file_name.endswith('.dat'):
                file_path = os.path.join(folder_name, file_name)

                with open(file_path, 'r') as f:
                    lines = f.readlines()

                # 1 значення для 2 стовбця
                first_value = float(lines[0].split()[1])

                # Нормування 2 стовбця на 1 значення в стовбці (точність до 8ого знаку)
                normalized_lines = [f"{line.split()[0]} {float(line.split()[1]) / first_value:.8f}\n" for line in lines]

                # Запис нормованих у файл
                with open(file_path, 'w') as f:
                    f.writelines(normalized_lines)

def create_images(folder_dict, save_directory, start_scale, end_scale, w, s):
    images_directory = os.path.join(save_directory)  

    if not os.path.exists(images_directory):
        os.makedirs(images_directory)

    for folder_name, _ in folder_dict.items():
        files = os.listdir(folder_name)

        # Ітерація по файлам в папці
        for file_name in files:
            if file_name.endswith('.dat'):
                file_path = os.path.join(folder_name, file_name)

                # Витягаємо тип файлу
                file_type = file_name[:-6]

                # Читаємо з файлу
                data = np.loadtxt(file_path)
                parameter = data[:, 1]

                # Цикл за значеннями масштабу
                for scale_value in range(start_scale, end_scale + 1):
                    # Вейвлет
                    waveletname = 'morl'
                    scales = np.arange(1, scale_value + 1) * s
                    cwtmatr, _ = pywt.cwt(parameter, scales, waveletname, sampling_period=100)

                    # Створення та збереження зображення
                    plt.imshow(cwtmatr, extent=[data[:, 0].min(), data[:, 0].max(), 1, end_scale],
                               cmap='jet', aspect='auto')
                    
                    # Видалення міток
                    plt.xticks([])
                    plt.yticks([])

                    # Створення ім'я для нових файлів
                    cropped_folder_name = folder_name.split('_')[0]  
                    cropped_folder_name = cropped_folder_name.replace('B', '')  
                    cropped_folder_name = cropped_folder_name.replace('p', '.')  

                    # Формування назви з врахуванням попереньої папки
                    if 'Jsc' in file_name:
                        save_filename = os.path.join(images_directory,
                                                     f'{file_name[:-4]}_B{cropped_folder_name}.png')
                    elif 'Eta' in file_name:
                        save_filename = os.path.join(images_directory,
                                                     f'{file_name[:-4]}_B{cropped_folder_name}.png')

                    plt.savefig(save_filename, bbox_inches='tight')
                    plt.close()

    print('Images saved successfully.')

# Шлях до бази
result_file_path = "ResultAll.dat"

df = pd.read_csv(result_file_path, sep=' ')

# Генерація словника
folder_dict = generate_folder_dict(df)

result = create_files(folder_dict, result_file_path)

# Нормування
normalize_files(folder_dict)

print(result)

# Створення зображень
save_directory = 'CWT_Images'
start_scale = 27
end_scale = 27
w = 2
s = 1
create_images(folder_dict, save_directory, start_scale, end_scale, w, s)