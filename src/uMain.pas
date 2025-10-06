unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, VclTee.TeeGDIPlus,
  Data.DB, VCLTee.TeEngine, Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart,
  VCLTee.DBChart, VCLTee.Series, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids,
  uWinUsageHelpers, System.Threading, System.Math;

type
  TfrmMain = class(TForm)
    pgcPrincipal: TPageControl;
    tbsCPU: TTabSheet;
    tbsRAM: TTabSheet;
    tbsStorage: TTabSheet;
    tbsNetwork: TTabSheet;
    dsoCPU: TDataSource;
    cdsCPU: TClientDataSet;
    TimerCPU: TTimer;
    cdsCPUstampdate: TDateTimeField;
    cdsCPUperc_usage: TFloatField;
    chartCPU: TDBChart;
    Series1: TLineSeries;
    dsoMem: TDataSource;
    cdsMem: TClientDataSet;
    cdsMemstampdate: TDateTimeField;
    cdsMemperc_usage: TFloatField;
    TimerMem: TTimer;
    chartMem: TDBChart;
    LineSeries1: TLineSeries;
    dsoStorage: TDataSource;
    cdsStorage: TClientDataSet;
    cdsStoragestampdate: TDateTimeField;
    dsoNetwork: TDataSource;
    cdsNetwork: TClientDataSet;
    cdsNetworkstampdate: TDateTimeField;
    chartStorage: TDBChart;
    LineSeries2: TLineSeries;
    Series2: TLineSeries;
    TimerStorage: TTimer;
    cdsStorageperc_usage_read: TLargeintField;
    cdsStorageperc_usage_write: TLargeintField;
    chartNetwork: TDBChart;
    LineSeries3: TLineSeries;
    LineSeries4: TLineSeries;
    TimerNetwork: TTimer;
    cdsNetworkperc_usage_read: TLargeintField;
    cdsNetworkperc_usage_write: TLargeintField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TimerCPUTimer(Sender: TObject);
    procedure TimerMemTimer(Sender: TObject);
    procedure TimerStorageTimer(Sender: TObject);
    procedure TimerNetworkTimer(Sender: TObject);
  private
    { Private declarations }
    procedure PreparaCPU;
    procedure PreparaMemoria;
    procedure PreparaStorage;
    procedure PreparaNetwork;
    procedure LoadCPUData;
    procedure LoadMemoriaData;
    procedure LoadStorageData;
    procedure LoadNetworkData;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  pgcPrincipal.ActivePageIndex := 0;
  PreparaCPU;
  PreparaMemoria;
  PreparaStorage;
  PreparaNetwork;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  TimerCPU.Enabled := True;
  TimerMem.Enabled := True;
  TimerStorage.Enabled := True;
  TimerNetwork.Enabled := True;
end;

procedure TfrmMain.PreparaCPU;
begin
  TimerCPU.Enabled := False;
  cdsCPU.Close;
  cdsCPU.CreateDataSet;
  cdsCPU.Open;
end;

procedure TfrmMain.PreparaMemoria;
begin
  TimerMem.Enabled := False;
  cdsMem.Close;
  cdsMem.CreateDataSet;
  cdsMem.Open;
end;

procedure TfrmMain.PreparaStorage;
begin
  TimerStorage.Enabled := False;
  cdsStorage.Close;
  cdsStorage.CreateDataSet;
  cdsStorage.Open;
end;

procedure TfrmMain.PreparaNetwork;
begin
  TimerNetwork.Enabled := False;
  cdsNetwork.Close;
  cdsNetwork.CreateDataSet;
  cdsNetwork.Open;
end;

procedure TfrmMain.TimerCPUTimer(Sender: TObject);
begin
  TimerCPU.Enabled := False;
  TTask.Run(
    procedure
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          LoadCPUData;
          TimerCPU.Enabled := True;
        end);
    end);
end;

procedure TfrmMain.TimerMemTimer(Sender: TObject);
begin
  TimerMem.Enabled := False;
  TTask.Run(
    procedure
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          LoadMemoriaData;
          TimerMem.Enabled := True;
        end);
    end);
end;

procedure TfrmMain.TimerNetworkTimer(Sender: TObject);
begin
  TimerNetwork.Enabled := False;
  TTask.Run(
    procedure
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          LoadNetworkData;
          TimerNetwork.Enabled := True;
        end);
    end);
end;

procedure TfrmMain.TimerStorageTimer(Sender: TObject);
begin
  TimerStorage.Enabled := False;
  TTask.Run(
    procedure
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          LoadStorageData;
          TimerStorage.Enabled := True;
        end);
    end);
end;

procedure TfrmMain.LoadCPUData;
const historyRows : Integer = 10;
var count : Integer;
    value : Double;
begin
  if cdsCPU.Active then
  begin
    cdsCPU.DisableControls;

    //Excluir registros além da quantidade histórico
    if (cdsCPU.RecordCount > historyRows) then
    begin
      count := 0;

      cdsCPU.First;
      while not cdsCPU.Eof do
      begin
        Inc(count);

        if count > historyRows then
        begin
          cdsCPU.Delete;
        end;

        cdsCPU.Next;
      end;
    end;

    cdsCPU.Insert;
    cdsCPUstampdate.Value := Now;

    value := GetCPUUsage;
    if (value < 0) then
      value := 0;

    if (value > 100) then
      value := 100;

    cdsCPUperc_usage.Value := value;
    cdsCPU.Post;

    chartCPU.ActiveSeriesLegend(0);
    chartCPU.RefreshData;

    cdsCPU.EnableControls;
  end;
end;

procedure TfrmMain.LoadMemoriaData;
const historyRows : Integer = 10;
var count : Integer;
    value : Double;
begin
  if cdsMem.Active then
  begin
    cdsMem.DisableControls;

    //Excluir registros além da quantidade histórico
    if (cdsMem.RecordCount > historyRows) then
    begin
      count := 0;

      cdsMem.First;
      while not cdsMem.Eof do
      begin
        Inc(count);

        if count > historyRows then
        begin
          cdsMem.Delete;
        end;

        cdsMem.Next;
      end;
    end;

    cdsMem.Insert;
    cdsMemstampdate.Value := Now;

    value := GetMemoryUsage;
    if (value < 0) then
      value := 0;

    if (value > 100) then
      value := 100;

    cdsMemperc_usage.Value := value;
    cdsMem.Post;

    chartMem.ActiveSeriesLegend(0);
    chartMem.RefreshData;

    cdsMem.EnableControls;
  end;
end;

procedure TfrmMain.LoadStorageData;
const historyRows : Integer = 10;
var count : Integer;
    valueRead, valueWrite : UInt64;
begin
  if cdsStorage.Active then
  begin
    cdsStorage.DisableControls;

    //Excluir registros além da quantidade histórico
    if (cdsStorage.RecordCount > historyRows) then
    begin
      count := 0;

      cdsStorage.First;
      while not cdsStorage.Eof do
      begin
        Inc(count);

        if count > historyRows then
        begin
          cdsStorage.Delete;
        end;

        cdsStorage.Next;
      end;
    end;

    cdsStorage.Insert;
    cdsStoragestampdate.Value := Now;

    valueRead := GetDiskReadBytes;
    if (valueRead < 0) then valueRead := 0;
    valueWrite := GetDiskWriteBytes;
    if (valueWrite < 0) then valueWrite := 0;
    cdsStorageperc_usage_read.Value := valueRead;
    cdsStorageperc_usage_write.Value := valueWrite;
    cdsStorage.Post;

    chartStorage.RefreshData;

    cdsStorage.EnableControls;
  end;
end;

procedure TfrmMain.LoadNetworkData;
const historyRows : Integer = 10;
var count : Integer;
    valueRead, valueWrite : UInt64;
begin
  if cdsNetwork.Active then
  begin
    cdsNetwork.DisableControls;

    //Excluir registros além da quantidade histórico
    if (cdsNetwork.RecordCount > historyRows) then
    begin
      count := 0;

      cdsNetwork.First;
      while not cdsNetwork.Eof do
      begin
        Inc(count);

        if count > historyRows then
        begin
          cdsNetwork.Delete;
        end;

        cdsNetwork.Next;
      end;
    end;

    cdsNetwork.Insert;
    cdsNetworkstampdate.Value := Now;

    valueRead :=  StrToInt64(FloatToStr(Floor(GetAllNetworkOutBytes / (8 * 1024 * 1024))));
    if (valueRead < 0) then valueRead := 0;
    valueWrite := StrToInt64(FloatToStr(Floor(GetAllNetworkInBytes / (8 * 1024 * 1024))));
    if (valueWrite < 0) then valueWrite := 0;
    cdsNetworkperc_usage_read.Value := valueRead;
    cdsNetworkperc_usage_write.Value := valueWrite;
    cdsNetwork.Post;

    chartNetwork.RefreshData;

    cdsNetwork.EnableControls;
  end;
end;

end.
