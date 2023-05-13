param appName string

param location string = resourceGroup().location

@allowed([
  'PROD'
  'DEV'
])
param env string

var storageAccountName = '${appName}st'

resource myStorage 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: (env == 'PROD') ? 'Standard_GRS' : 'Standard_LRS'
  }
}
