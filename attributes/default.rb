default['cas_haproxy']['stats'] = {
    enabled: false,
    mode: 'http',
    port: '9001',
    hide_version: true,
    realm: 'HAProxy-Stats',
    uri: '/haproxy_stats',
    auth: 'admin:admin'
}
