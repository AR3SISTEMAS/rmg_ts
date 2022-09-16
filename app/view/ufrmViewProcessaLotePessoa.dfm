inherited frmViewProcessaLotePessoa: TfrmViewProcessaLotePessoa
  Caption = 'Processa lote de pessoas'
  ClientHeight = 529
  ClientWidth = 828
  OnCreate = FormCreate
  ExplicitWidth = 834
  ExplicitHeight = 558
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 822
    Height = 50
    Align = alTop
    Caption = 'Arquivo de Pessoas'
    TabOrder = 0
    object Label1: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 60
      Height = 27
      Align = alLeft
      Caption = 'Caminho'
      Layout = tlCenter
      ExplicitTop = 20
      ExplicitHeight = 31
    end
    object txtArquivo: TEdit
      AlignWithMargins = True
      Left = 71
      Top = 18
      Width = 714
      Height = 27
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 63
      ExplicitTop = 30
      ExplicitWidth = 547
      ExplicitHeight = 21
    end
    object btnAbrirArquivo: TButton
      AlignWithMargins = True
      Left = 791
      Top = 18
      Width = 26
      Height = 27
      Align = alRight
      Caption = '...'
      TabOrder = 1
      ExplicitLeft = 616
      ExplicitTop = 25
      ExplicitHeight = 25
    end
  end
  object grdPessoas: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 59
    Width = 822
    Height = 414
    Align = alClient
    DataSource = dsPessoas
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object pnlBotoes: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 479
    Width = 822
    Height = 47
    Align = alBottom
    TabOrder = 2
    ExplicitLeft = 74
    object Bevel1: TBevel
      Left = 1
      Top = 1
      Width = 820
      Height = 3
      Align = alTop
    end
    object btnProcessar: TButton
      AlignWithMargins = True
      Left = 4
      Top = 7
      Width = 141
      Height = 36
      Align = alLeft
      Caption = 'Processar'
      TabOrder = 0
      OnClick = btnProcessarClick
      ExplicitTop = 10
    end
    object pnlAndamento: TPanel
      AlignWithMargins = True
      Left = 440
      Top = 7
      Width = 378
      Height = 36
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      Visible = False
      ExplicitLeft = 439
      ExplicitTop = 10
      object pgbAndamento: TProgressBar
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 372
        Height = 30
        Align = alClient
        Smooth = True
        TabOrder = 0
      end
    end
  end
  object fmdCSVPessoas: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 320
    Top = 360
    object fmdCSVPessoasflnatureza: TIntegerField
      FieldName = 'flnatureza'
    end
    object fmdCSVPessoasdsdocumento: TStringField
      FieldName = 'dsdocumento'
    end
    object fmdCSVPessoasnmprimeiro: TStringField
      FieldName = 'nmprimeiro'
      Size = 100
    end
    object fmdCSVPessoasnmsegundo: TStringField
      FieldName = 'nmsegundo'
      Size = 100
    end
    object fmdCSVPessoasdsCep: TStringField
      FieldName = 'dsCep'
      Size = 8
    end
  end
  object dsPessoas: TDataSource
    AutoEdit = False
    DataSet = fmdCSVPessoas
    Left = 400
    Top = 360
  end
  object FDBatchMove: TFDBatchMove
    Mappings = <>
    LogFileName = 'Data.log'
    Left = 320
    Top = 304
  end
end
