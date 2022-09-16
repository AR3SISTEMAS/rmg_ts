inherited frmCadPessoa: TfrmCadPessoa
  Caption = 'CADASTRO DE PESSOAS'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    ExplicitLeft = 8
    ExplicitTop = 8
    inherited tbsListaRegistros: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 4
      inherited pnlNavegacao: TPanel
        object lblAlertaRegistros: TLabel [0]
          AlignWithMargins = True
          Left = 407
          Top = 4
          Width = 302
          Height = 37
          Align = alClient
          Alignment = taCenter
          Caption = 
            'Existem mais de [] registros no banco de dados, por favor, reali' +
            'za uma pesquisa para prosseguir'
          Layout = tlCenter
          ExplicitLeft = 127
          ExplicitWidth = 462
          ExplicitHeight = 13
        end
        inherited dbnNavegacao: TDBNavigator
          Hints.Strings = ()
        end
        inherited dbnAcoes: TDBNavigator
          Hints.Strings = ()
          BeforeAction = dbnAcoesBeforeAction
          OnClick = dbnAcoesClick
          ExplicitLeft = 135
          ExplicitTop = 0
          ExplicitHeight = 37
        end
      end
      inherited grdPesquisa: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'idpessoa'
            Title.Alignment = taCenter
            Title.Caption = 'ID'
            Width = 62
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'dsdocumento'
            Title.Alignment = taCenter
            Title.Caption = 'Documento'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nmprimeiro'
            Title.Alignment = taCenter
            Title.Caption = 'Nome'
            Width = 176
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nmsegundo'
            Title.Alignment = taCenter
            Title.Caption = 'Sobrenome'
            Width = 190
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'dtregistro'
            Title.Alignment = taCenter
            Title.Caption = 'Dt. Registro'
            Visible = True
          end>
      end
      inherited pnlCabecalhoPesquisa: TPanel
        inherited txtPesquisar: TEdit
          ExplicitTop = 6
          ExplicitHeight = 31
        end
        inherited btnPesquisar: TButton
          OnClick = btnPesquisarClick
        end
      end
    end
    inherited tbsRegistro: TTabSheet
      object grbCEPPessoa: TGroupBox [0]
        AlignWithMargins = True
        Left = 3
        Top = 215
        Width = 713
        Height = 213
        Align = alClient
        Caption = 'CEP'#39's'
        TabOrder = 0
        object pnlCeps: TPanel
          AlignWithMargins = True
          Left = 5
          Top = 18
          Width = 703
          Height = 33
          Align = alTop
          TabOrder = 0
          object btnIncluirCEP: TButton
            AlignWithMargins = True
            Left = 543
            Top = 4
            Width = 75
            Height = 25
            Align = alRight
            Caption = 'Incluir CEP'
            TabOrder = 0
            OnClick = btnIncluirCEPClick
            ExplicitTop = 8
          end
          object btnExcluirCEP: TButton
            AlignWithMargins = True
            Left = 624
            Top = 4
            Width = 75
            Height = 25
            Align = alRight
            Caption = 'Excluir CEP'
            TabOrder = 1
            OnClick = btnExcluirCEPClick
            ExplicitTop = 8
          end
        end
        object grdCep: TDBGrid
          AlignWithMargins = True
          Left = 5
          Top = 57
          Width = 703
          Height = 151
          Align = alClient
          DataSource = dsTabEndereco
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ReadOnly = True
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'dscep'
              Title.Alignment = taCenter
              Title.Caption = 'CEP'
              Width = 134
              Visible = True
            end>
        end
      end
      inherited pnlGravacao: TPanel
        TabOrder = 1
        ExplicitLeft = 3
        ExplicitTop = 434
        inherited dbnGravacao: TDBNavigator
          Hints.Strings = ()
          ExplicitLeft = 5
          ExplicitTop = 0
        end
      end
      object grbPessoa: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 713
        Height = 206
        Align = alTop
        Caption = 'Pessoa'
        TabOrder = 2
        object lblId: TLabel
          Left = 19
          Top = 32
          Width = 11
          Height = 13
          Caption = 'ID'
        end
        object lblNome: TLabel
          Left = 13
          Top = 87
          Width = 27
          Height = 13
          Caption = 'Nome'
        end
        object lblSobrenome: TLabel
          Left = 13
          Top = 143
          Width = 54
          Height = 13
          Caption = 'Sobrenome'
        end
        object lblDataRegistro: TLabel
          Left = 110
          Top = 32
          Width = 78
          Height = 13
          Caption = 'Data do registro'
        end
        object tdbId: TDBEdit
          Left = 15
          Top = 51
          Width = 89
          Height = 21
          TabStop = False
          DataField = 'idpessoa'
          DataSource = dsTabPrincipal
          ReadOnly = True
          TabOrder = 1
        end
        object tdbNome: TDBEdit
          Left = 13
          Top = 106
          Width = 682
          Height = 21
          DataField = 'nmprimeiro'
          DataSource = dsTabPrincipal
          TabOrder = 2
        end
        object tdbSobrenome: TDBEdit
          Left = 13
          Top = 162
          Width = 682
          Height = 21
          DataField = 'nmsegundo'
          DataSource = dsTabPrincipal
          TabOrder = 3
        end
        object tdbDataRegistro: TDBEdit
          Left = 110
          Top = 51
          Width = 138
          Height = 21
          TabStop = False
          DataField = 'dtregistro'
          DataSource = dsTabPrincipal
          ReadOnly = True
          TabOrder = 4
        end
        object grbNatureza: TGroupBox
          AlignWithMargins = True
          Left = 270
          Top = 22
          Width = 425
          Height = 72
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 65
          Caption = 'Natureza'
          TabOrder = 0
          object lblDocumento: TLabel
            Left = 192
            Top = 13
            Width = 54
            Height = 13
            Caption = 'Documento'
          end
          object tdbDocumento: TDBEdit
            Left = 192
            Top = 34
            Width = 217
            Height = 21
            DataField = 'dsdocumento'
            DataSource = dsTabPrincipal
            TabOrder = 2
            OnKeyPress = tdbDocumentoKeyPress
          end
          object chkPessoaFisica: TRadioButton
            Left = 16
            Top = 36
            Width = 73
            Height = 17
            Caption = 'F'#237'sica'
            TabOrder = 0
            OnClick = chkPessoaFisicaClick
          end
          object chkPessoaJuridica: TRadioButton
            Left = 104
            Top = 36
            Width = 65
            Height = 17
            Caption = 'Jur'#237'dica'
            TabOrder = 1
            OnClick = chkPessoaFisicaClick
          end
        end
      end
    end
  end
  inherited fmdTabPrincipal: TFDMemTable
    StoreDefs = True
    object fmdTabPrincipalidpessoa: TIntegerField
      FieldName = 'idpessoa'
    end
    object fmdTabPrincipalflnatureza: TIntegerField
      FieldName = 'flnatureza'
    end
    object fmdTabPrincipaldsdocumento: TStringField
      FieldName = 'dsdocumento'
    end
    object fmdTabPrincipalnmprimeiro: TStringField
      FieldName = 'nmprimeiro'
      Size = 100
    end
    object fmdTabPrincipalnmsegundo: TStringField
      FieldName = 'nmsegundo'
      Size = 100
    end
    object fmdTabPrincipaldtregistro: TDateTimeField
      FieldName = 'dtregistro'
    end
  end
  object fmdTabEndereco: TFDMemTable [3]
    Active = True
    FieldDefs = <
      item
        Name = 'idendereco'
        DataType = ftInteger
      end
      item
        Name = 'idpessoa'
        DataType = ftInteger
      end
      item
        Name = 'dscep'
        DataType = ftString
        Size = 15
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 439
    Top = 462
    object fmdTabEnderecoidendereco: TIntegerField
      FieldName = 'idendereco'
    end
    object fmdTabEnderecoidpessoa: TIntegerField
      FieldName = 'idpessoa'
    end
    object fmdTabEnderecodscep: TStringField
      FieldName = 'dscep'
      Size = 15
    end
  end
  object dsTabEndereco: TDataSource [4]
    DataSet = fmdTabEndereco
    OnStateChange = dsTabPrincipalStateChange
    Left = 336
    Top = 464
  end
end
