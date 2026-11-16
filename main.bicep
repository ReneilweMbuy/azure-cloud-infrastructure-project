
targetScope = 'resourceGroup'

resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  name: 'PracticeVNet'
}

output virtualNetworkId string = vnet.id
