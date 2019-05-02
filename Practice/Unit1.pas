unit Unit1;

interface

uses
  System.JSON, System.Generics.Collections, System.JSON.Serializers, Unit2,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btn1: TButton;
    mmo1: TMemo;
    btn2: TButton;
    btn3: TButton;
    btn4: TButton;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
  UserJson: string;
  Serializer: TJsonSerializer;
  Student: TStudent;
begin
  UserJson := '{"FName":"邓艺","FAge":11}';
  Serializer := TJsonSerializer.Create;
  Student := Serializer.Deserialize<TStudent>(UserJson);
  mmo1.Lines.Add('反序列化:' + Student.Name + ',' + Student.Age.ToString);
end;

procedure TForm1.btn2Click(Sender: TObject);
var
  UserJson: string;
  Serializer: TJsonSerializer;
  Student, Student1: TStudent;
begin
  Student := TStudent.Create;
  Student1 := TStudent.Create;
  Student.Name := '邓建城';
  Student.Age := 15;
  Serializer := TJsonSerializer.Create;
  Student1 := Serializer.Deserialize<TStudent>(Serializer.Serialize<TStudent>(Student));

  mmo1.Lines.Add('序列化:' + Serializer.Serialize<TStudent>(Student) + '::::' + Student1.Name);

end;

procedure TForm1.btn3Click(Sender: TObject);
var
  UserJson: string;
  Student, Student1: TStudent;
  List: TList<TStudent>;
  Serializer: TJsonSerializer;
begin

  List := TList<TStudent>.Create;
  List.Add(TStudent.Create('王淑宜', 18));
  List.Add(TStudent.Create('邓艺', 19));
  Serializer := TJsonSerializer.Create;

  mmo1.Lines.Add('序列化:' + Serializer.Serialize<TList<TStudent>>(List));
end;

procedure TForm1.btn4Click(Sender: TObject);
var
  List: TList<TStudent>;
  Serializer: TJsonSerializer;
  Stu: TStudent;
  UserJson: string;
begin
  UserJson := '{"FListHelper":{"FCount":2},"FItems":[{"FName":"王淑宜","FAge":18},{"FName":"邓艺","FAge":19}],"FComparer":{}}';
  Serializer := TJsonSerializer.Create();
  List := Serializer.Deserialize<TList<TStudent>>(UserJson);

  for Stu in List do begin

    mmo1.Lines.Add('反序列化:' + Stu.Name + ',' + Stu.Age.ToString);
  end;

  mmo1.Lines.Add('取其中的值:' + TJSONObject.ParseJSONValue(UserJson).GetValue<TJSONObject>('FListHelper').Getvalue<string>('FCount'));
  mmo1.Lines.Add('取其中的值:' + TJSONObject.ParseJSONValue(UserJson).GetValue<TJSONArray>('FItems').Count.ToString);

end;

end.

