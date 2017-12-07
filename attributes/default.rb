default['cas_haproxy']['stats_http'] = {
    enabled: false,
    mode: 'http',
    port: '9001',
    hide_version: true,
    realm: 'HAProxy-Stats',
    uri: '/haproxy_stats',
    auth: 'admin:admin'
}

default['cas_haproxy']['stats_socket'] = {
    enabled: false,
    path: '/var/run/haproxy.sock',
    user: 'root',
    group: 'root',
    mode: 600,
    level: 'operator',
    timeout: '10s',
    maxconn: 10
}
