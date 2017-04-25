#!/bin/sh

pyang --ietf -f yang -p combined-model --ietf-to-state-module combined-model/ietf-bgp-types.yang > generated-extra-state-model/ietf-bgp-types-state.yang
pyang --ietf -f yang -p combined-model --ietf-to-state-module combined-model/ietf-policy-types.yang > generated-extra-state-model/ietf-policy-types-state.yang
pyang --ietf -f yang -p combined-model --ietf-to-state-module combined-model/ietf-bgp-common.yang > generated-extra-state-model/ietf-bgp-common-state.yang
pyang --ietf -f yang -p combined-model --ietf-to-state-module combined-model/ietf-bgp-common-structure.yang > generated-extra-state-model/ietf-bgp-common-structure-state.yang
pyang --ietf -f yang -p combined-model --ietf-to-state-module combined-model/ietf-bgp-global.yang > generated-extra-state-model/ietf-bgp-global-state.yang
pyang --ietf -f yang -p combined-model --ietf-to-state-module combined-model/ietf-bgp-peer-group.yang > generated-extra-state-model/ietf-bgp-peer-group-state.yang
pyang --ietf -f yang -p combined-model --ietf-to-state-module combined-model/ietf-bgp-policy.yang > generated-extra-state-model/ietf-bgp-policy-state.yang
pyang --ietf -f yang -p combined-model --ietf-to-state-module combined-model/ietf-routing-policy.yang > generated-extra-state-model/ietf-routing-policy-state.yang
pyang --ietf -f yang -p combined-model --ietf-to-state-module combined-model/ietf-bgp-neighbor.yang > generated-extra-state-model/ietf-bgp-neighbor-state.yang
pyang --ietf -f yang -p combined-model --ietf-to-state-module combined-model/ietf-bgp-common-multiprotocol.yang > generated-extra-state-model/ietf-bgp-common-multiprotocol-state.yang 
pyang --ietf -f yang -p combined-model --ietf-to-state-module combined-model/ietf-bgp.yang > generated-extra-state-model/ietf-bgp-state.yang
