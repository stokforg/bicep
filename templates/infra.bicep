param appName string

param location string = resourceGroup().location

@allowed([
  'PROD'
  'DEV'
])
param env string

param sku string = 'F1'

var storageAccountName = '${appName}st'

resource myStorage 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: (env == 'PROD') ? 'Standard_GRS' : 'Standard_LRS'
  }
}



resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: '${appName}-plan'
  location: location
  kind: 'linux'
  properties: {
    reserved: true
  }
  sku: {
    name: sku
    tier: 'Free'
    size: 'F1'
  }
}

resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: appName
  location: location
  kind: 'app'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'WEBSITE_DOTNET_VERSION'
          value: '6.0'
        }
      ]
      linuxFxVersion: 'DOTNETCORE|6.0'
    }
  }
}
