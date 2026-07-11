const windowsUpdateDomains = [
  "functional.events.data.microsoft.com",
  "self.events.data.microsoft.com",
  "slscr.update.microsoft.com",
];

const wingetDomains = [
  "storeedgefd.dsx.mp.microsoft.com",
  "cdn.winget.microsoft.com",
]

function toDomainRule(url) {
  return `DOMAIN,${url},🔰国外流量`;
}

function main(config, profileName) {
  const proxies = config["proxy-groups"][0].proxies;
  const aiProxyGroupName = "🤖AI";
  const proxyGroups = [
    ...config["proxy-groups"],
    {
      name: aiProxyGroupName,
      type: "select",
      proxies,
      "exclude-filter": "港",
    },
  ];

  const rules = [
    ...[...windowsUpdateDomains, ...wingetDomains].map(toDomainRule),
    `DOMAIN,copilot.microsoft.com,${aiProxyGroupName}`,
    "DOMAIN,qbittorrent.org,DIRECT",

    `RULE-SET,ai_non_ip,${aiProxyGroupName}`,

    "RULE-SET,reject_non_ip,REJECT",
    "RULE-SET,reject_domainset,REJECT",
    // "RULE-SET,reject_extra_domainset,REJECT",

    "RULE-SET,reject_ip,REJECT",
    "RULE-SET,reject_non_ip_drop,REJECT-DROP",
    "RULE-SET,reject_non_ip_no_drop,REJECT",

    ...config.rules,
  ];

  return {
    ...config,
    "proxy-groups": proxyGroups,
    rules,
  };
}
