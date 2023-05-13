param appName string

param location string = resourceGroup().location

@allowed([
  'PROD'
  'DEV'
])
param env string

module storage1 'storage.bicep' = {
  name: '${deployment().name}-st1'
  params: {
    appName: appName
    env: env
    location: location
  }
}

module storage2 'storage2.bicep' = {
  name: '${deployment().name}-st2'
  params: {
    appName: appName
    env: env
    location: location
  }
}
