unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage;

type
  TForm1 = class(TForm)
    All: TPageControl;
    EfficientNet: TTabSheet;
    MobileNet: TTabSheet;
    NASNetLarge: TTabSheet;
    ResNet: TTabSheet;
    Xception: TTabSheet;
    YOLO: TTabSheet;
    Panel1: TPanel;
    Label1: TLabel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure AllDrawTab(Control: TCustomTabControl; TabIndex: Integer;
    const Rect: TRect; Active: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
procedure TForm1.AllDrawTab(Control: TCustomTabControl; TabIndex: Integer;
  const Rect: TRect; Active: Boolean);
var
  Flags: Longint;
  S: string;
  R: TRect;
  BgColor: TColor;
//  P: TPanel;
begin
//
//P := TPanel.Create(All.ActivePage);
//  P.Align := alClient;        // займає всю сторінку
//  P.BevelOuter := bvNone;
//  P.Color := clYellow;        // фон вкладки
//  P.Parent := All.ActivePage;

//   All.Pages[0].Color := clYellow;
//All.Pages[1].Color := clSkyBlue;
//All.Pages[2].Color := clWhite;

  S := All.Pages[TabIndex].Caption;
  R := Rect;
//  InflateRect(R, -10, -3); // поля (чим менші числа, тим ближче текст до країв)

  // Шрифт для заголовку
  All.Canvas.Font.Size := 14;
  All.Canvas.Font.Style := [fsBold];

//  case TabIndex of
//    0: All.Canvas.Font.Color := clRed;
//    1: All.Canvas.Font.Color := clGreen;
//    2: All.Canvas.Font.Color := clBlue;
//    3: All.Canvas.Font.Color := clPurple;
//  else
//    All.Canvas.Font.Color := clBlack; // інші вкладки чорні
//  end;

  case TabIndex of
    0: BgColor := RGB(255, 182, 193);
    1: BgColor := clLime;
    4: BgColor := RGB(176, 224, 230);
    3: BgColor := clYellow;
    2: BgColor := RGB(255, 218, 185);
  else
    BgColor := RGB(230, 230, 250);
  end;

//All.ActivePage.Color := clSkyBlue;

  Flags := DT_CENTER or DT_VCENTER or DT_SINGLELINE;

 All.Canvas.Brush.Color := BgColor;
 All.Canvas.FillRect(R);

  All.Canvas.Pen.Color := clBlack; // колір межі
  All.Canvas.Rectangle(R);

  DrawText(All.Canvas.Handle, PChar(S), Length(S), R, Flags);

//  All.Canvas.Pen.Color := clBtnShadow;
//  All.Canvas.MoveTo(Rect.Left, Rect.Bottom);
//  All.Canvas.LineTo(Rect.Right, Rect.Bottom);
//
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  Tab: TTabSheet;
  i: Integer;
begin
  // Дозволяємо власне малювання вкладок
  All.OwnerDraw := True;

  // Задаємо висоту та ширину вкладок
  All.TabHeight := 40;
  All.TabWidth := 180;

// All.Pages[0].Color := clYellow;
//All.Pages[1].Color := clSkyBlue;
//All.Pages[2].Color := clWhite;
  // Додаємо кілька вкладок у циклі
//  for i := 1 to 3 do
//  begin
//    Tab := TTabSheet.Create(All);
//    Tab.PageControl := All;
//    Tab.Caption := 'Вкладка ' + IntToStr(i);
//  end;
end;

end.
