inherited frmModeloCRUD: TfrmModeloCRUD
  Caption = 'frmModeloCRUD'
  ClientHeight = 519
  ClientWidth = 743
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  ExplicitWidth = 749
  ExplicitHeight = 548
  PixelsPerInch = 96
  TextHeight = 13
  object pgcPrincipal: TPageControl
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 727
    Height = 503
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    ActivePage = tbsListaRegistros
    Align = alClient
    TabHeight = 25
    TabOrder = 0
    TabPosition = tpBottom
    ExplicitLeft = 13
    ExplicitTop = 3
    object tbsListaRegistros: TTabSheet
      Caption = 'Pesquisa'
      ExplicitLeft = 0
      ExplicitTop = 0
      object pnlNavegacao: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 422
        Width = 713
        Height = 45
        Align = alBottom
        TabOrder = 0
        object dbnNavegacao: TDBNavigator
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 125
          Height = 37
          DataSource = dsTabPrincipal
          VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
          Align = alLeft
          ConfirmDelete = False
          TabOrder = 0
          ExplicitHeight = 25
        end
        object dbnAcoes: TDBNavigator
          AlignWithMargins = True
          Left = 135
          Top = 4
          Width = 266
          Height = 37
          DataSource = dsTabPrincipal
          VisibleButtons = [nbInsert, nbDelete, nbEdit]
          Align = alLeft
          ConfirmDelete = False
          TabOrder = 1
          ExplicitLeft = 191
          ExplicitHeight = 25
        end
      end
      object grdPesquisa: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 46
        Width = 713
        Height = 370
        Align = alClient
        DataSource = dsTabPrincipal
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object pnlCabecalhoPesquisa: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 713
        Height = 37
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object txtPesquisar: TEdit
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 616
          Height = 31
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ExplicitHeight = 27
        end
        object btnPesquisar: TButton
          AlignWithMargins = True
          Left = 625
          Top = 3
          Width = 85
          Height = 31
          Align = alRight
          Caption = 'Pesquisar'
          DropDownMenu = ppmPesquisa
          Style = bsSplitButton
          TabOrder = 1
          ExplicitTop = 6
        end
      end
    end
    object tbsRegistro: TTabSheet
      Caption = 'Registro'
      ImageIndex = 1
      object pnlGravacao: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 434
        Width = 713
        Height = 33
        Align = alBottom
        TabOrder = 0
        ExplicitLeft = 6
        ExplicitTop = 437
        object dbnGravacao: TDBNavigator
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 181
          Height = 25
          DataSource = dsTabPrincipal
          VisibleButtons = [nbPost, nbCancel]
          Align = alLeft
          TabOrder = 0
          BeforeAction = dbnGravacaoBeforeAction
          ExplicitLeft = 0
        end
      end
    end
  end
  object dsTabPrincipal: TDataSource
    DataSet = fmdTabPrincipal
    OnStateChange = dsTabPrincipalStateChange
    Left = 568
    Top = 464
  end
  object fmdTabPrincipal: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 511
    Top = 462
  end
  object ppmPesquisa: TPopupMenu
    Left = 604
    Top = 460
  end
end
