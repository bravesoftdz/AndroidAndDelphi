program HeaderFooterApplication;

uses
  System.StartUpCopy,
  FMX.Forms,
  HeaderFooterTemplate in 'HeaderFooterTemplate.pas' {HeaderFooterForm};

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.CreateForm(THeaderFooterForm, HeaderFooterForm);
  Application.Run;
end.
