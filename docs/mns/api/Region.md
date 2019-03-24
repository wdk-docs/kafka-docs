# Region

## Region(city?:string|City, network?:string|NetworkType, zone?:string|Zone)
The *Region* class help your specifying the region of datacenter.

city: String | City, optional. It can be the data center name, like "hangzhou", "beijing" or "west-1", "southeast-2";
or it can be a pre-defined city enum value, like `AliMNS.City.Beijing`, `AliMNS.City.Tokyo`, check [Region.ts#L169-L188](ts/Region.ts#L169-L188) for the full list.
The default is "hangzhou".

network: String | NetworkType, optional.
If it is a string, should be ""(empty string) or "-internal" or "-internal-vpc".
If it is [NetworkType](ts/Region.ts#L144-L148) enum, should be `AliMNS.NetworkType.Public` or `AliMNS.NetworkType.Internal` or `AliMNS.NetworkType.VPC`.
The default is ""(empty string), means `AliMNS.NetworkType.Public` network.

zone: String | Zone, optional.
If it is a string, should be data center zone, like "cn", "us", "eu", "me" or "ap".
If it is [Zone](ts/Region.ts#L150-L156) enum, should be `AliMNS.Zone.China`, `AliMNS.Zone.AsiaPacific`, `AliMNS.Zone.Europe`, `AliMNS.Zone.UniteState` or `AliMNS.Zone.MiddleEast`.
The default is "cn", means `AliMNS.Zone.China`.
This value will be ignored if city parameter is a pre-defined city enum value, because we can deduce zone from city.

samples
```javascript
// because hangzhou is the default value.
var regionHangzhou = new AliMNS.Region();

// beijing public network in china
var regionBeijing = new AliMNS.Region("beijing");
regionBeijing = new AliMNS.Region(AliMNS.City.Beijing);
regionBeijing = new AliMNS.Region("beijing", "");
regionBeijing = new AliMNS.Region("beijing", AliMNS.NetworkType.Public);
regionBeijing = new AliMNS.Region("beijing", "", "cn");

// east asia in internal network
var regionJapan = new AliMNS.Region(AliMNS.City.Japan, AliMNS.NetworkType.Internal);
regionJapan = new AliMNS.Region("northeast-1", AliMNS.NetworkType.Internal, "ap");
regionJapan = new AliMNS.Region("northeast-1", "-internal", "ap");

// south asia in vpc network
var regionSingapore = new AliMNS.Region(AliMNS.City.Singapore, AliMNS.NetworkType.VPC);
regionSingapore = new AliMNS.Region(AliMNS.City.Singapore, "-internal-vpc");
regionSingapore = new AliMNS.Region("southeast-1", "-internal-vpc", AliMNS.Zone.AsiaPacific);
regionSingapore = new AliMNS.Region("southeast-1", "-internal-vpc", "ap");
```

## region.toString()
Convert region object to string value.