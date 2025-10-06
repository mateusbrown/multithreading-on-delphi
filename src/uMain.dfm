object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Monitor de Recursos do Sistema'
  ClientHeight = 617
  ClientWidth = 1018
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object pgcPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 1018
    Height = 617
    ActivePage = tbsNetwork
    Align = alClient
    TabOrder = 0
    object tbsCPU: TTabSheet
      Caption = 'CPU'
      object chartCPU: TDBChart
        Left = 0
        Top = 0
        Width = 1010
        Height = 587
        Title.Text.Strings = (
          'TDBChart')
        Title.Visible = False
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMaximum = False
        LeftAxis.Maximum = 100.000000000000000000
        LeftAxis.Title.Visible = False
        Pages.AutoScale = True
        View3D = False
        Align = alClient
        TabOrder = 0
        AutoSize = True
        ExplicitWidth = 250
        ExplicitHeight = 282
        DefaultCanvas = 'TGDIPlusCanvas'
        PrintMargins = (
          15
          38
          15
          38)
        ColorPaletteIndex = 13
        object Series1: TLineSeries
          HoverElement = [heCurrent]
          Legend.Visible = False
          Marks.Visible = True
          DataSource = cdsCPU
          ShowInLegend = False
          Title = 'CPU'
          XLabelsSource = 'perc_usage'
          Brush.BackColor = clDefault
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          XValues.ValueSource = 'stampdate'
          YValues.Name = 'Y'
          YValues.Order = loNone
          YValues.ValueSource = 'perc_usage'
        end
      end
    end
    object tbsRAM: TTabSheet
      Caption = 'Mem'#243'ria'
      ImageIndex = 1
      object chartMem: TDBChart
        Left = 0
        Top = 0
        Width = 1010
        Height = 587
        Title.Text.Strings = (
          'TDBChart')
        Title.Visible = False
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMaximum = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.Maximum = 100.000000000000000000
        LeftAxis.Title.Visible = False
        Pages.AutoScale = True
        View3D = False
        Align = alClient
        TabOrder = 0
        AutoSize = True
        ExplicitWidth = 250
        ExplicitHeight = 282
        DefaultCanvas = 'TGDIPlusCanvas'
        PrintMargins = (
          15
          38
          15
          38)
        ColorPaletteIndex = 13
        object LineSeries1: TLineSeries
          HoverElement = [heCurrent]
          Legend.Visible = False
          Marks.Visible = True
          DataSource = cdsMem
          ShowInLegend = False
          Title = 'Memoria'
          XLabelsSource = 'perc_usage'
          Brush.BackColor = clDefault
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          XValues.ValueSource = 'stampdate'
          YValues.Name = 'Y'
          YValues.Order = loNone
          YValues.ValueSource = 'perc_usage'
        end
      end
    end
    object tbsStorage: TTabSheet
      Caption = 'Armazenamento'
      ImageIndex = 2
      object chartStorage: TDBChart
        Left = 0
        Top = 0
        Width = 1010
        Height = 587
        Title.Text.Strings = (
          'TDBChart')
        Title.Visible = False
        LeftAxis.Title.Visible = False
        Pages.AutoScale = True
        View3D = False
        Align = alClient
        TabOrder = 0
        AutoSize = True
        ExplicitWidth = 250
        ExplicitHeight = 282
        DefaultCanvas = 'TGDIPlusCanvas'
        PrintMargins = (
          15
          38
          15
          38)
        ColorPaletteIndex = 13
        object LineSeries2: TLineSeries
          HoverElement = [heCurrent]
          Legend.Visible = False
          Marks.Visible = True
          DataSource = cdsStorage
          ShowInLegend = False
          Title = 'Armazenamento-Escrita'
          XLabelsSource = 'perc_usage_write'
          Brush.BackColor = clDefault
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          XValues.ValueSource = 'stampdate'
          YValues.Name = 'Y'
          YValues.Order = loNone
          YValues.ValueSource = 'perc_usage_write'
        end
        object Series2: TLineSeries
          HoverElement = [heCurrent]
          Legend.Visible = False
          Marks.Visible = True
          DataSource = cdsStorage
          ShowInLegend = False
          Title = 'Armazenamento-Leitura'
          XLabelsSource = 'perc_usage_read'
          Brush.BackColor = clDefault
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          XValues.ValueSource = 'stampdate'
          YValues.Name = 'Y'
          YValues.Order = loNone
          YValues.ValueSource = 'perc_usage_read'
        end
      end
    end
    object tbsNetwork: TTabSheet
      Caption = 'Rede'
      ImageIndex = 3
      object chartNetwork: TDBChart
        Left = 0
        Top = 0
        Width = 1010
        Height = 587
        Title.Text.Strings = (
          'TDBChart')
        Title.Visible = False
        LeftAxis.Title.Visible = False
        Pages.AutoScale = True
        View3D = False
        Align = alClient
        TabOrder = 0
        AutoSize = True
        ExplicitWidth = 250
        ExplicitHeight = 282
        DefaultCanvas = 'TGDIPlusCanvas'
        PrintMargins = (
          15
          38
          15
          38)
        ColorPaletteIndex = 13
        object LineSeries3: TLineSeries
          HoverElement = [heCurrent]
          Legend.Visible = False
          Marks.Visible = True
          DataSource = cdsNetwork
          ShowInLegend = False
          Title = 'Rede-Escrita'
          XLabelsSource = 'perc_usage_write'
          Brush.BackColor = clDefault
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          XValues.ValueSource = 'stampdate'
          YValues.Name = 'Y'
          YValues.Order = loNone
          YValues.ValueSource = 'perc_usage_write'
        end
        object LineSeries4: TLineSeries
          HoverElement = [heCurrent]
          Legend.Visible = False
          Marks.Visible = True
          DataSource = cdsNetwork
          ShowInLegend = False
          Title = 'Rede-Leitura'
          XLabelsSource = 'perc_usage_read'
          Brush.BackColor = clDefault
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          XValues.ValueSource = 'stampdate'
          YValues.Name = 'Y'
          YValues.Order = loNone
          YValues.ValueSource = 'perc_usage_read'
        end
      end
    end
  end
  object dsoCPU: TDataSource
    DataSet = cdsCPU
    Left = 28
    Top = 282
  end
  object cdsCPU: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'cdsCPUIndexstampdate'
        Fields = 'stampdate'
        Options = [ixDescending]
        Source = 'stampdate'
      end>
    IndexName = 'cdsCPUIndexstampdate'
    Params = <>
    StoreDefs = True
    Left = 28
    Top = 362
    object cdsCPUstampdate: TDateTimeField
      FieldName = 'stampdate'
    end
    object cdsCPUperc_usage: TFloatField
      FieldName = 'perc_usage'
      DisplayFormat = '##0.0000'
    end
  end
  object TimerCPU: TTimer
    Enabled = False
    OnTimer = TimerCPUTimer
    Left = 844
    Top = 130
  end
  object dsoMem: TDataSource
    DataSet = cdsMem
    Left = 100
    Top = 282
  end
  object cdsMem: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'cdsMemIndexstampdate'
        Fields = 'stampdate'
        Options = [ixDescending]
        Source = 'stampdate'
      end>
    IndexName = 'cdsMemIndexstampdate'
    Params = <>
    StoreDefs = True
    Left = 100
    Top = 362
    object cdsMemstampdate: TDateTimeField
      FieldName = 'stampdate'
    end
    object cdsMemperc_usage: TFloatField
      FieldName = 'perc_usage'
      DisplayFormat = '##0.0000'
    end
  end
  object TimerMem: TTimer
    Enabled = False
    OnTimer = TimerMemTimer
    Left = 844
    Top = 202
  end
  object dsoStorage: TDataSource
    DataSet = cdsStorage
    Left = 172
    Top = 282
  end
  object cdsStorage: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'cdsStorageIndexstampdate'
        Fields = 'stampdate'
        Options = [ixDescending]
        Source = 'stampdate'
      end>
    IndexName = 'cdsStorageIndexstampdate'
    Params = <>
    StoreDefs = True
    Left = 172
    Top = 362
    object cdsStoragestampdate: TDateTimeField
      FieldName = 'stampdate'
    end
    object cdsStorageperc_usage_read: TLargeintField
      FieldName = 'perc_usage_read'
    end
    object cdsStorageperc_usage_write: TLargeintField
      FieldName = 'perc_usage_write'
    end
  end
  object dsoNetwork: TDataSource
    DataSet = cdsNetwork
    Left = 268
    Top = 282
  end
  object cdsNetwork: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'cdsNetworkIndexstampdate'
        Fields = 'stampdate'
        Options = [ixDescending]
        Source = 'stampdate'
      end>
    IndexName = 'cdsNetworkIndexstampdate'
    Params = <>
    StoreDefs = True
    Left = 276
    Top = 362
    object cdsNetworkstampdate: TDateTimeField
      FieldName = 'stampdate'
    end
    object cdsNetworkperc_usage_read: TLargeintField
      FieldName = 'perc_usage_read'
    end
    object cdsNetworkperc_usage_write: TLargeintField
      FieldName = 'perc_usage_write'
    end
  end
  object TimerStorage: TTimer
    Enabled = False
    OnTimer = TimerStorageTimer
    Left = 844
    Top = 282
  end
  object TimerNetwork: TTimer
    Enabled = False
    OnTimer = TimerNetworkTimer
    Left = 852
    Top = 370
  end
end
