unit UFormUtils;

interface

uses
  Vcl.Forms, Vcl.Mask;

type
  TFormUtils = class
    private
    protected
    public
    class procedure SetMainForm(NewMainForm: TForm);
    class function tirarMascara(MskEdit : TMaskEdit) : String;
  end;

implementation

class procedure TFormUtils.SetMainForm(NewMainForm: TForm);
var
  tmpMain: ^TCustomForm;
begin
  tmpMain := @Application.Mainform;
  tmpMain^ := NewMainForm;
end;

class function TFormUtils.tirarMascara(MskEdit: TMaskEdit): String;
var
  Mask: String;
begin
  Mask := MskEdit.EditMask;
  MskEdit.EditMask := '';
  Result := MskEdit.Text;
  MskEdit.EditMask := Mask;
end;
end.
