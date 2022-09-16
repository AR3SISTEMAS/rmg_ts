unit udmUI;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls;

type
  TdmUI = class(TDataModule)
    imlApp: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmUI: TdmUI;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
