object frmCadastradoPedidos: TfrmCadastradoPedidos
  Left = 0
  Top = 0
  Caption = 'Cadastro de Pedidos'
  ClientHeight = 461
  ClientWidth = 972
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 385
    Top = 0
    Height = 442
    ExplicitLeft = 352
    ExplicitTop = 336
    ExplicitHeight = 100
  end
  object statusBarPedido: TStatusBar
    Left = 0
    Top = 442
    Width = 972
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Text = 'Valor Total'
        Width = 100
      end>
  end
  object gpbItemProduto: TGroupBox
    Left = 0
    Top = 0
    Width = 385
    Height = 442
    Align = alLeft
    Caption = 'Itens do pedido'
    TabOrder = 1
    object lblNomeCliente: TLabel
      Left = 103
      Top = 50
      Width = 90
      Height = 14
      Caption = 'lblNomeCliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDescricaoProduto: TLabel
      Left = 103
      Top = 130
      Width = 90
      Height = 14
      Caption = 'lblNomeCliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 8
      Top = 168
      Width = 56
      Height = 13
      Caption = 'Quantidade'
    end
    object Label2: TLabel
      Left = 8
      Top = 227
      Width = 67
      Height = 13
      Caption = 'Pre'#231'o Unit'#225'rio'
    end
    object edtCodigoCliente: TLabeledEdit
      Left = 8
      Top = 48
      Width = 89
      Height = 21
      EditLabel.Width = 82
      EditLabel.Height = 13
      EditLabel.Caption = 'C'#243'digo do cliente'
      NumbersOnly = True
      TabOrder = 0
      OnChange = edtCodigoClienteChange
      OnExit = edtCodigoClienteExit
    end
    object edtCodigoProduto: TLabeledEdit
      Left = 8
      Top = 128
      Width = 89
      Height = 21
      EditLabel.Width = 89
      EditLabel.Height = 13
      EditLabel.Caption = 'C'#243'digo do produto'
      NumbersOnly = True
      TabOrder = 1
      OnExit = edtCodigoProdutoExit
    end
    object btnSalvarItemProduto: TButton
      Left = 160
      Top = 243
      Width = 146
      Height = 25
      Caption = 'Confirmar Item do Pedido'
      TabOrder = 2
      OnClick = btnSalvarItemProdutoClick
    end
    object edtQuantidade: TNumberBox
      Left = 8
      Top = 187
      Width = 89
      Height = 21
      Mode = nbmFloat
      TabOrder = 3
      Value = 1.000000000000000000
    end
    object edtPrecoUnitario: TNumberBox
      Left = 8
      Top = 243
      Width = 89
      Height = 21
      Mode = nbmCurrency
      TabOrder = 4
    end
  end
  object gpbPedido: TGroupBox
    Left = 388
    Top = 0
    Width = 584
    Height = 442
    Align = alClient
    Caption = 'Pedido'
    TabOrder = 2
    ExplicitLeft = 352
    ExplicitTop = -6
    ExplicitWidth = 626
    DesignSize = (
      584
      442)
    object btnGravarPedido: TButton
      Left = 429
      Top = 14
      Width = 152
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'GRAVAR PEDIDO'
      TabOrder = 0
      OnClick = btnGravarPedidoClick
      ExplicitLeft = 468
    end
    object stgPedidos: TStringGrid
      Left = 6
      Top = 45
      Width = 575
      Height = 391
      Align = alCustom
      Anchors = [akLeft, akTop, akRight, akBottom]
      FixedCols = 0
      TabOrder = 1
      OnKeyUp = stgPedidosKeyUp
      ExplicitWidth = 614
    end
    object btnCarregarPedido: TButton
      Left = 6
      Top = 14
      Width = 123
      Height = 25
      Caption = 'CARREGAR PEDIDO'
      TabOrder = 2
      OnClick = btnCarregarPedidoClick
    end
    object btnExcluiPedido: TButton
      Left = 150
      Top = 14
      Width = 123
      Height = 25
      Caption = 'EXCLUIR PEDIDO'
      TabOrder = 3
      OnClick = btnExcluiPedidoClick
    end
  end
  object FDConnection1: TFDConnection
    Left = 272
    Top = 64
  end
end
