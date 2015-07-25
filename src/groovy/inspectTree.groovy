/**
 * Created by daniel.jimenez on 24/07/2015.
 */

def inspectTree(Collection collection) {
    def sizesMap = [:]
    def identifiers = []
    collection.each { rootItem->
        if(rootItem instanceof Map) {
            if(rootItem.value instanceof Collection) {
                sizesMap."${rootItem.key}" = rootItem.value.size()
                inspectTree(rootItem.value)
            }
            else {
                identifiers << rootItem.value
            }
        }
        if(rootItem instanceof List || rootItem instanceof Object[]) {
            identifiers << rootItem
        }
    }
    println "sizes: $sizesMap, ids: $identifiers"
}



def data = [
        [tipo_de_cliente: 'privado'],
        [ingenieria_en_sitio: [qa_cantidad:6]],
        [volumetria: 'medium'],
        [tecnologia: [
                [firewall:[
                        ['firewall_vpn_ipsec', 'firewall_ha']]],
                [ips:[
                        ['ips_ha']]]]],
        [:]
]


inspectTree(data)


data = [
        tipo_de_cliente: 'privado',
        ingenieria_en_sitio: [
                [
                        qa_cantidad: 6,
                        qa_alguna_otra: [1, 'asdf']]],
        volumetria: 'medium',
        tecnologia: [
                firewall: [
                        ['firewall_vpn_ipsec', 'firewall_ha', 5],
                        ['antivirus', 'firewall_ha', 1]],
                ips: [
                        ['ips_ha']]
        ]
]


data.each { categoName, categoVal->
//    if(categoVal )
}




