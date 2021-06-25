object dmPedidoVenda: TdmPedidoVenda
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 363
  Width = 694
  object dspPesqCliente: TDataSetProvider
    DataSet = sqlPesqCliente
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 72
    Top = 120
  end
  object sqlPesqCliente: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    SQLConnection = sqlConexao
    Left = 72
    Top = 48
    object sqlPesqClienteNome: TStringField
      FieldName = 'Nome'
      Size = 100
    end
  end
  object cdsPesqCliente: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPesqCliente'
    Left = 72
    Top = 192
    object cdsPesqClienteNome: TStringField
      FieldName = 'Nome'
      Size = 100
    end
  end
  object sqlConexao: TSQLConnection
    ConnectionName = 'MySQLConnection'
    DriverName = 'MySQL'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXMySQL'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver200.' +
        'bpl'
      
        'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borla' +
        'nd.Data.DbxCommonDriver,Version=20.0.0.0,Culture=neutral,PublicK' +
        'eyToken=91d62ebb5b0d1b1b'
      
        'MetaDataPackageLoader=TDBXMySqlMetaDataCommandFactory,DbxMySQLDr' +
        'iver200.bpl'
      
        'MetaDataAssemblyLoader=Borland.Data.TDBXMySqlMetaDataCommandFact' +
        'ory,Borland.Data.DbxMySQLDriver,Version=20.0.0.0,Culture=neutral' +
        ',PublicKeyToken=91d62ebb5b0d1b1b'
      'GetDriverFunc=getSQLDriverMYSQL'
      'LibraryName=dbxmys.dll'
      'LibraryNameOsx=libsqlmys.dylib'
      'VendorLib=LIBMYSQL.dll'
      'VendorLibWin64=libmysql.dll'
      'VendorLibOsx=libmysqlclient.dylib'
      'MaxBlobSize=-1'
      'DriverName=MySQL'
      'HostName=localhost'
      'Database=pedido_venda'
      'User_Name=root'
      'Password=1234'
      'ServerCharSet='
      'BlobSize=-1'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'Compressed=False'
      'Encrypted=False'
      'ConnectTimeout=60')
    Connected = True
    Left = 536
    Top = 56
  end
  object FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink
    VendorLib = 'D:\ARQUIVOS\Prova_Sistema_PEDIDOVENDA\dll\libmysql.dll'
    Left = 536
    Top = 136
  end
  object dspPesqProduto: TDataSetProvider
    DataSet = sqlPesqProduto
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 168
    Top = 120
  end
  object sqlPesqProduto: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    SQLConnection = sqlConexao
    Left = 168
    Top = 48
    object sqlPesqProdutoDescricao: TStringField
      FieldName = 'Descricao'
      Size = 50
    end
    object sqlPesqProdutoPco_Venda: TSingleField
      FieldName = 'Pco_Venda'
    end
  end
  object cdsPesqProduto: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPesqProduto'
    Left = 168
    Top = 192
    object cdsPesqProdutoDescricao: TStringField
      FieldName = 'Descricao'
      Size = 50
    end
    object cdsPesqProdutoPco_Venda: TSingleField
      FieldName = 'Pco_Venda'
    end
  end
  object dspPedido: TDataSetProvider
    DataSet = sqlPedido
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 296
    Top = 120
  end
  object sqlPedido: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    SQLConnection = sqlConexao
    Left = 296
    Top = 48
  end
  object cdsPedido: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPedido'
    Left = 296
    Top = 192
  end
  object cdsDadosPedido: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    Left = 415
    Top = 51
    object cdsDadosPedidoChave: TIntegerField
      FieldName = 'Chave'
      ProviderFlags = []
    end
    object cdsDadosPedidoCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object cdsDadosPedidoProduto: TStringField
      FieldName = 'Produto'
      Size = 50
    end
    object cdsDadosPedidoQtd: TIntegerField
      FieldName = 'Qtd'
      OnChange = cdsDadosPedidoQtdChange
    end
    object cdsDadosPedidoValorUnit: TSingleField
      FieldName = 'ValorUnit'
      OnChange = cdsDadosPedidoValorUnitChange
    end
    object cdsDadosPedidoValorTotal: TSingleField
      FieldName = 'ValorTotal'
    end
  end
end
