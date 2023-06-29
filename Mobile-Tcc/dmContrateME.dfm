object dm_ContrateME: Tdm_ContrateME
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 571
  Width = 516
  object conexao: TFDConnection
    Params.Strings = (
      'User_Name=root'
      'Database=contrateMe'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 16
    Top = 8
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 88
    Top = 8
  end
  object DLL: TFDPhysMySQLDriverLink
    Left = 160
    Top = 8
  end
  object Transacao: TFDTransaction
    Connection = conexao
    Left = 208
    Top = 8
  end
  object qryLogin: TFDQuery
    Connection = conexao
    Left = 16
    Top = 57
  end
  object qryConsulta: TFDQuery
    Connection = conexao
    Left = 88
    Top = 57
  end
  object qryCidade: TFDQuery
    Connection = conexao
    Left = 160
    Top = 57
  end
  object SQLExecutar: TFDQuery
    Connection = conexao
    Left = 16
    Top = 113
  end
  object qryConsulta2: TFDQuery
    Connection = conexao
    Left = 88
    Top = 113
  end
  object qryConsulta3: TFDQuery
    Connection = conexao
    Left = 88
    Top = 164
  end
  object qryConsulta4: TFDQuery
    Connection = conexao
    Left = 88
    Top = 220
  end
  object qryPessoas: TFDQuery
    Connection = conexao
    Left = 160
    Top = 120
  end
  object qryEmpresa: TFDQuery
    Connection = conexao
    Left = 160
    Top = 176
  end
end
