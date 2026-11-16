
targetScope = 'resourceGroup'

param location string = 'southafricanorth'

// Reference existing security groups
resource webNsg 'Microsoft.Network/networkSecurityGroups@2024-05-01' existing = {
  name: 'WebNSG'
}

resource databaseNsg 'Microsoft.Network/networkSecurityGroups@2024-05-01' existing = {
  name: 'DatabaseNSG'
}

// Manage the virtual network and its subnets together
resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: 'PracticeVNet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: [
      {
        name: 'WebSubnet'
        properties: {
          addressPrefix: '10.0.1.0/24'
          defaultOutboundAccess: false
          privateEndpointNetworkPolicies: 'Disabled'
          networkSecurityGroup: {
            id: webNsg.id
          }
        }
      }
      {
        name: 'DatabaseSubnet'
        properties: {
          addressPrefix: '10.0.2.0/24'
          defaultOutboundAccess: false
          privateEndpointNetworkPolicies: 'Disabled'
          networkSecurityGroup: {
            id: databaseNsg.id
          }
        }
      }
    ]
  }
}

output virtualNetworkId string = vnet.id
