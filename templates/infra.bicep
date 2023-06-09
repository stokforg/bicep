param appName string

param location string = resourceGroup().location

@allowed([
  'PROD'
  'DEV'
])
param env string

param sku string = 'F1'

module mydatamodule 'data/data.bicep' = {
  name: '${deployment().name}-data'
  params: {
    appName: appName
    env: env
    location: location
  }
}

module apphostingmodule 'app/appHosting.bicep' = {
  name: '${deployment().name}-apphosting'
  params: {
    appName: appName 
    location: location
  }
}
