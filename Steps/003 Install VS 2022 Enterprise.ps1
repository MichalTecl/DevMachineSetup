# see list of VS workloads https://learn.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-enterprise?view=vs-2022&preserve-view=true

choco install visualstudio2022enterprise -y --params='--add Microsoft.VisualStudio.Workload.ManagedDesktop;includeRecommended;includeOptional --add Microsoft.VisualStudio.Workload.NetWeb;includeRecommended;includeOptional'