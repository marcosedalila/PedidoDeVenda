object frmPedidoVenda: TfrmPedidoVenda
  Left = 0
  Top = 0
  Caption = 'Pedido de Venda'
  ClientHeight = 570
  ClientWidth = 822
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object gbPedidoVenda: TGroupBox
    Left = 8
    Top = 6
    Width = 808
    Height = 556
    TabOrder = 0
    object lblCliente: TLabel
      Left = 49
      Top = 35
      Width = 37
      Height = 13
      Caption = 'Cliente:'
    end
    object lblProduto: TLabel
      Left = 49
      Top = 75
      Width = 42
      Height = 13
      Caption = 'Produto:'
    end
    object lblQuantidade: TLabel
      Left = 65
      Top = 115
      Width = 22
      Height = 13
      Caption = 'Qtd:'
    end
    object lblValorUnit: TLabel
      Left = 19
      Top = 155
      Width = 67
      Height = 13
      Caption = 'Valor unit'#225'rio:'
    end
    object lblValorTotal: TLabel
      Left = 18
      Top = 523
      Width = 78
      Height = 13
      Caption = 'Total do Pedido:'
    end
    object lblTotalPedido: TLabel
      Left = 102
      Top = 523
      Width = 66
      Height = 13
      Caption = 'lblTotalPedido'
    end
    object lblNumeroPedido: TLabel
      Left = 377
      Top = 197
      Width = 76
      Height = 13
      Caption = 'N'#250'mero Pedido:'
    end
    object lblExcluirPedido: TLabel
      Left = 337
      Top = 522
      Width = 116
      Height = 13
      Caption = 'Cancelar Pedido(Excluir)'
    end
    object edQuantidade: TEdit
      Left = 102
      Top = 112
      Width = 121
      Height = 21
      TabOrder = 4
    end
    object GroupBox1: TGroupBox
      Left = 19
      Top = 232
      Width = 773
      Height = 273
      Caption = ' Itens do pedido '
      TabOrder = 10
      object gdDadosPedido: TDBGrid
        Left = 16
        Top = 24
        Width = 743
        Height = 234
        DataSource = dsDadosPedido
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnKeyDown = gdDadosPedidoKeyDown
        Columns = <
          item
            Expanded = False
            FieldName = 'Codigo'
            ReadOnly = True
            Title.Caption = 'C'#243'digo'
            Width = 93
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Produto'
            ReadOnly = True
            Width = 285
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Qtd'
            Title.Caption = 'Quantidade'
            Width = 122
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ValorUnit'
            Title.Caption = 'Valor Unit.'
            Width = 104
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ValorTotal'
            ReadOnly = True
            Title.Caption = 'Valor Total'
            Width = 102
            Visible = True
          end>
      end
    end
    object btnAdd: TBitBtn
      Left = 21
      Top = 192
      Width = 75
      Height = 25
      Caption = 'INSERIR'
      TabOrder = 6
      OnClick = btnAddClick
    end
    object btnPesquisar: TBitBtn
      Left = 548
      Top = 192
      Width = 106
      Height = 25
      Caption = 'PESQUISAR'
      TabOrder = 8
      OnClick = btnPesquisarClick
    end
    object edCodigoCliente: TEdit
      Left = 102
      Top = 32
      Width = 51
      Height = 21
      TabOrder = 0
      OnExit = edCodigoClienteExit
    end
    object edDescricaoNome: TEdit
      Left = 167
      Top = 32
      Width = 274
      Height = 21
      Enabled = False
      TabOrder = 1
    end
    object btnLimpar: TBitBtn
      Left = 672
      Top = 192
      Width = 106
      Height = 25
      Caption = 'LIMPAR PESQUISA'
      TabOrder = 9
      OnClick = btnLimparClick
    end
    object btnExcluir: TBitBtn
      Left = 548
      Top = 517
      Width = 106
      Height = 25
      Caption = 'EXCLUIR'
      TabOrder = 12
      OnClick = btnExcluirClick
    end
    object edCodigoProduto: TEdit
      Left = 102
      Top = 72
      Width = 51
      Height = 21
      TabOrder = 2
      OnExit = edCodigoProdutoExit
    end
    object edDescricaoProduto: TEdit
      Left = 167
      Top = 72
      Width = 274
      Height = 21
      Enabled = False
      TabOrder = 3
    end
    object edValorUnit: TEdit
      Left = 102
      Top = 152
      Width = 121
      Height = 21
      TabOrder = 5
    end
    object btnGravarPedido: TBitBtn
      Left = 672
      Top = 517
      Width = 118
      Height = 25
      Caption = 'GRAVAR PEDIDO'
      TabOrder = 13
      OnClick = btnGravarPedidoClick
    end
    object edNumeroPedido: TEdit
      Left = 459
      Top = 194
      Width = 82
      Height = 21
      TabOrder = 7
    end
    object edExcluirPedido: TEdit
      Left = 459
      Top = 519
      Width = 82
      Height = 21
      TabOrder = 11
    end
  end
  object dsPesqCliente: TDataSource
    DataSet = dmPedidoVenda.cdsPesqCliente
    Left = 656
    Top = 35
  end
  object dsPesqProduto: TDataSource
    DataSet = dmPedidoVenda.cdsPesqProduto
    Left = 728
    Top = 35
  end
  object dsDadosPedido: TDataSource
    DataSet = dmPedidoVenda.cdsDadosPedido
    Left = 680
    Top = 339
  end
  object dsPedido: TDataSource
    DataSet = dmPedidoVenda.cdsPedido
    Left = 648
    Top = 115
  end
end
