require 'mechanize'
require 'debugger'

module Craigslist
  def scrape(url)
    agent = Mechanize.new
    index_page = agent.get(url)
    rows = agent.page.parser.css('.row')
    if agent.page.parser.css('.npcontrolcenter').children.children.to_a[4].attributes['href']
      next_link = agent.page.parser.css('.npcontrolcenter').children.children.to_a[4].attributes['href'].value
    else
      puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    end
    debugger
    job_links = []
    rows.each do |row|
      if row.children.children.to_a[5].attributes['href']
        job_links << row.children.children.to_a[5].attributes['href'].value
      end
    end

    job_links.each do |link|
      url = "http://sfbay.craigslist.org#{link}"
      job_page = agent.get(url)
      email = job_page.links[6].node.children.text
      title = agent.page.parser.css('h2').text.strip
      description = agent.page.parser.css('#postingbody').text

      puts "#{url} \n #{email} \n #{title} \m #{description}"
    end
    
    scrape(next_link) if next_link
  end
end

# scrape("http://sfbay.craigslist.org/search/jjj?zoomToPosting=&query=ruby+rails&srchType=A")

CITIES = ["http://auburn.craigslist.org/", "http://bham.craigslist.org/", "http://dothan.craigslist.org/", "http://shoals.craigslist.org/", "http://gadsden.craigslist.org/", "http://huntsville.craigslist.org/", "http://mobile.craigslist.org/", "http://montgomery.craigslist.org/", "http://tuscaloosa.craigslist.org/", "http://anchorage.craigslist.org/", "http://fairbanks.craigslist.org/", "http://kenai.craigslist.org/", "http://juneau.craigslist.org/", "http://flagstaff.craigslist.org/", "http://mohave.craigslist.org/", "http://phoenix.craigslist.org/", "http://prescott.craigslist.org/", "http://showlow.craigslist.org/", "http://sierravista.craigslist.org/", "http://tucson.craigslist.org/", "http://yuma.craigslist.org/", "http://fayar.craigslist.org/", "http://fortsmith.craigslist.org/", "http://jonesboro.craigslist.org/", "http://littlerock.craigslist.org/", "http://texarkana.craigslist.org/", "http://bakersfield.craigslist.org/", "http://chico.craigslist.org/", "http://fresno.craigslist.org/", "http://goldcountry.craigslist.org/", "http://hanford.craigslist.org/", "http://humboldt.craigslist.org/", "http://imperial.craigslist.org/", "http://inlandempire.craigslist.org/", "http://losangeles.craigslist.org/", "http://mendocino.craigslist.org/", "http://merced.craigslist.org/", "http://modesto.craigslist.org/", "http://monterey.craigslist.org/", "http://orangecounty.craigslist.org/", "http://palmsprings.craigslist.org/", "http://redding.craigslist.org/", "http://sacramento.craigslist.org/", "http://sandiego.craigslist.org/", "http://sfbay.craigslist.org/", "http://slo.craigslist.org/", "http://santabarbara.craigslist.org/", "http://santamaria.craigslist.org/", "http://siskiyou.craigslist.org/", "http://stockton.craigslist.org/", "http://susanville.craigslist.org/", "http://ventura.craigslist.org/", "http://visalia.craigslist.org/", "http://yubasutter.craigslist.org/", "http://boulder.craigslist.org/", "http://cosprings.craigslist.org/", "http://denver.craigslist.org/", "http://eastco.craigslist.org/", "http://fortcollins.craigslist.org/", "http://rockies.craigslist.org/", "http://pueblo.craigslist.org/", "http://westslope.craigslist.org/", "http://newlondon.craigslist.org/", "http://hartford.craigslist.org/", "http://newhaven.craigslist.org/", "http://nwct.craigslist.org/", "http://delaware.craigslist.org/", "http://washingtondc.craigslist.org/", "http://daytona.craigslist.org/", "http://keys.craigslist.org/", "http://fortlauderdale.craigslist.org/", "http://fortmyers.craigslist.org/", "http://gainesville.craigslist.org/", "http://cfl.craigslist.org/", "http://jacksonville.craigslist.org/", "http://lakeland.craigslist.org/", "http://lakecity.craigslist.org/", "http://ocala.craigslist.org/", "http://okaloosa.craigslist.org/", "http://orlando.craigslist.org/", "http://panamacity.craigslist.org/", "http://pensacola.craigslist.org/", "http://sarasota.craigslist.org/", "http://miami.craigslist.org/", "http://spacecoast.craigslist.org/", "http://staugustine.craigslist.org/", "http://tallahassee.craigslist.org/", "http://tampa.craigslist.org/", "http://treasure.craigslist.org/", "http://westpalmbeach.craigslist.org/", "http://albanyga.craigslist.org/", "http://athensga.craigslist.org/", "http://atlanta.craigslist.org/", "http://augusta.craigslist.org/", "http://brunswick.craigslist.org/", "http://columbusga.craigslist.org/", "http://macon.craigslist.org/", "http://nwga.craigslist.org/", "http://savannah.craigslist.org/", "http://statesboro.craigslist.org/", "http://valdosta.craigslist.org/", "http://honolulu.craigslist.org/", "http://boise.craigslist.org/", "http://eastidaho.craigslist.org/", "http://lewiston.craigslist.org/", "http://twinfalls.craigslist.org/", "http://bn.craigslist.org/", "http://chambana.craigslist.org/", "http://chicago.craigslist.org/", "http://decatur.craigslist.org/", "http://lasalle.craigslist.org/", "http://mattoon.craigslist.org/", "http://peoria.craigslist.org/", "http://rockford.craigslist.org/", "http://carbondale.craigslist.org/", "http://springfieldil.craigslist.org/", "http://quincy.craigslist.org/", "http://bloomington.craigslist.org/", "http://evansville.craigslist.org/", "http://fortwayne.craigslist.org/", "http://indianapolis.craigslist.org/", "http://kokomo.craigslist.org/", "http://tippecanoe.craigslist.org/", "http://muncie.craigslist.org/", "http://richmondin.craigslist.org/", "http://southbend.craigslist.org/", "http://terrehaute.craigslist.org/", "http://ames.craigslist.org/", "http://cedarrapids.craigslist.org/", "http://desmoines.craigslist.org/", "http://dubuque.craigslist.org/", "http://fortdodge.craigslist.org/", "http://iowacity.craigslist.org/", "http://masoncity.craigslist.org/", "http://quadcities.craigslist.org/", "http://siouxcity.craigslist.org/", "http://ottumwa.craigslist.org/", "http://waterloo.craigslist.org/", "http://lawrence.craigslist.org/", "http://ksu.craigslist.org/", "http://nwks.craigslist.org/", "http://salina.craigslist.org/", "http://seks.craigslist.org/", "http://swks.craigslist.org/", "http://topeka.craigslist.org/", "http://wichita.craigslist.org/", "http://bgky.craigslist.org/", "http://eastky.craigslist.org/", "http://lexington.craigslist.org/", "http://louisville.craigslist.org/", "http://owensboro.craigslist.org/", "http://westky.craigslist.org/", "http://batonrouge.craigslist.org/", "http://cenla.craigslist.org/", "http://houma.craigslist.org/", "http://lafayette.craigslist.org/", "http://lakecharles.craigslist.org/", "http://monroe.craigslist.org/", "http://neworleans.craigslist.org/", "http://shreveport.craigslist.org/", "http://maine.craigslist.org/", "http://annapolis.craigslist.org/", "http://baltimore.craigslist.org/", "http://easternshore.craigslist.org/", "http://frederick.craigslist.org/", "http://smd.craigslist.org/", "http://westmd.craigslist.org/", "http://boston.craigslist.org/", "http://capecod.craigslist.org/", "http://southcoast.craigslist.org/", "http://westernmass.craigslist.org/", "http://worcester.craigslist.org/", "http://annarbor.craigslist.org/", "http://battlecreek.craigslist.org/", "http://centralmich.craigslist.org/", "http://detroit.craigslist.org/", "http://flint.craigslist.org/", "http://grandrapids.craigslist.org/", "http://holland.craigslist.org/", "http://jxn.craigslist.org/", "http://kalamazoo.craigslist.org/", "http://lansing.craigslist.org/", "http://monroemi.craigslist.org/", "http://muskegon.craigslist.org/", "http://nmi.craigslist.org/", "http://porthuron.craigslist.org/", "http://saginaw.craigslist.org/", "http://swmi.craigslist.org/", "http://thumb.craigslist.org/", "http://up.craigslist.org/", "http://bemidji.craigslist.org/", "http://brainerd.craigslist.org/", "http://duluth.craigslist.org/", "http://mankato.craigslist.org/", "http://minneapolis.craigslist.org/", "http://rmn.craigslist.org/", "http://marshall.craigslist.org/", "http://stcloud.craigslist.org/", "http://gulfport.craigslist.org/", "http://hattiesburg.craigslist.org/", "http://jackson.craigslist.org/", "http://meridian.craigslist.org/", "http://northmiss.craigslist.org/", "http://natchez.craigslist.org/", "http://columbiamo.craigslist.org/", "http://joplin.craigslist.org/", "http://kansascity.craigslist.org/", "http://kirksville.craigslist.org/", "http://loz.craigslist.org/", "http://semo.craigslist.org/", "http://springfield.craigslist.org/", "http://stjoseph.craigslist.org/", "http://stlouis.craigslist.org/", "http://billings.craigslist.org/", "http://bozeman.craigslist.org/", "http://butte.craigslist.org/", "http://greatfalls.craigslist.org/", "http://helena.craigslist.org/", "http://kalispell.craigslist.org/", "http://missoula.craigslist.org/", "http://montana.craigslist.org/", "http://grandisland.craigslist.org/", "http://lincoln.craigslist.org/", "http://northplatte.craigslist.org/", "http://omaha.craigslist.org/", "http://scottsbluff.craigslist.org/", "http://elko.craigslist.org/", "http://lasvegas.craigslist.org/", "http://reno.craigslist.org/", "http://nh.craigslist.org/", "http://cnj.craigslist.org/", "http://jerseyshore.craigslist.org/", "http://newjersey.craigslist.org/", "http://southjersey.craigslist.org/", "http://albuquerque.craigslist.org/", "http://clovis.craigslist.org/", "http://farmington.craigslist.org/", "http://lascruces.craigslist.org/", "http://roswell.craigslist.org/", "http://santafe.craigslist.org/", "http://albany.craigslist.org/", "http://binghamton.craigslist.org/", "http://buffalo.craigslist.org/", "http://catskills.craigslist.org/", "http://chautauqua.craigslist.org/", "http://elmira.craigslist.org/", "http://fingerlakes.craigslist.org/", "http://glensfalls.craigslist.org/", "http://hudsonvalley.craigslist.org/", "http://ithaca.craigslist.org/", "http://longisland.craigslist.org/", "http://newyork.craigslist.org/", "http://oneonta.craigslist.org/", "http://plattsburgh.craigslist.org/", "http://potsdam.craigslist.org/", "http://rochester.craigslist.org/", "http://syracuse.craigslist.org/", "http://twintiers.craigslist.org/", "http://utica.craigslist.org/", "http://watertown.craigslist.org/", "http://asheville.craigslist.org/", "http://boone.craigslist.org/", "http://charlotte.craigslist.org/", "http://eastnc.craigslist.org/", "http://fayetteville.craigslist.org/", "http://greensboro.craigslist.org/", "http://hickory.craigslist.org/", "http://onslow.craigslist.org/", "http://outerbanks.craigslist.org/", "http://raleigh.craigslist.org/", "http://wilmington.craigslist.org/", "http://winstonsalem.craigslist.org/", "http://bismarck.craigslist.org/", "http://fargo.craigslist.org/", "http://grandforks.craigslist.org/", "http://nd.craigslist.org/", "http://akroncanton.craigslist.org/", "http://ashtabula.craigslist.org/", "http://athensohio.craigslist.org/", "http://chillicothe.craigslist.org/", "http://cincinnati.craigslist.org/", "http://cleveland.craigslist.org/", "http://columbus.craigslist.org/", "http://dayton.craigslist.org/", "http://limaohio.craigslist.org/", "http://mansfield.craigslist.org/", "http://sandusky.craigslist.org/", "http://toledo.craigslist.org/", "http://tuscarawas.craigslist.org/", "http://youngstown.craigslist.org/", "http://zanesville.craigslist.org/", "http://lawton.craigslist.org/", "http://enid.craigslist.org/", "http://oklahomacity.craigslist.org/", "http://stillwater.craigslist.org/", "http://tulsa.craigslist.org/", "http://bend.craigslist.org/", "http://corvallis.craigslist.org/", "http://eastoregon.craigslist.org/", "http://eugene.craigslist.org/", "http://klamath.craigslist.org/", "http://medford.craigslist.org/", "http://oregoncoast.craigslist.org/", "http://portland.craigslist.org/", "http://roseburg.craigslist.org/", "http://salem.craigslist.org/", "http://altoona.craigslist.org/", "http://chambersburg.craigslist.org/", "http://erie.craigslist.org/", "http://harrisburg.craigslist.org/", "http://lancaster.craigslist.org/", "http://allentown.craigslist.org/", "http://meadville.craigslist.org/", "http://philadelphia.craigslist.org/", "http://pittsburgh.craigslist.org/", "http://poconos.craigslist.org/", "http://reading.craigslist.org/", "http://scranton.craigslist.org/", "http://pennstate.craigslist.org/", "http://williamsport.craigslist.org/", "http://york.craigslist.org/", "http://providence.craigslist.org/", "http://charleston.craigslist.org/", "http://columbia.craigslist.org/", "http://florencesc.craigslist.org/", "http://greenville.craigslist.org/", "http://hiltonhead.craigslist.org/", "http://myrtlebeach.craigslist.org/", "http://nesd.craigslist.org/", "http://csd.craigslist.org/", "http://rapidcity.craigslist.org/", "http://siouxfalls.craigslist.org/", "http://sd.craigslist.org/", "http://chattanooga.craigslist.org/", "http://clarksville.craigslist.org/", "http://cookeville.craigslist.org/", "http://jacksontn.craigslist.org/", "http://knoxville.craigslist.org/", "http://memphis.craigslist.org/", "http://nashville.craigslist.org/", "http://tricities.craigslist.org/", "http://abilene.craigslist.org/", "http://amarillo.craigslist.org/", "http://austin.craigslist.org/", "http://beaumont.craigslist.org/", "http://brownsville.craigslist.org/", "http://collegestation.craigslist.org/", "http://corpuschristi.craigslist.org/", "http://dallas.craigslist.org/", "http://nacogdoches.craigslist.org/", "http://delrio.craigslist.org/", "http://elpaso.craigslist.org/", "http://galveston.craigslist.org/", "http://houston.craigslist.org/", "http://killeen.craigslist.org/", "http://laredo.craigslist.org/", "http://lubbock.craigslist.org/", "http://mcallen.craigslist.org/", "http://odessa.craigslist.org/", "http://sanangelo.craigslist.org/", "http://sanantonio.craigslist.org/", "http://sanmarcos.craigslist.org/", "http://bigbend.craigslist.org/", "http://texoma.craigslist.org/", "http://easttexas.craigslist.org/", "http://victoriatx.craigslist.org/", "http://waco.craigslist.org/", "http://wichitafalls.craigslist.org/", "http://logan.craigslist.org/", "http://ogden.craigslist.org/", "http://provo.craigslist.org/", "http://saltlakecity.craigslist.org/", "http://stgeorge.craigslist.org/", "http://burlington.craigslist.org/", "http://charlottesville.craigslist.org/", "http://danville.craigslist.org/", "http://fredericksburg.craigslist.org/", "http://norfolk.craigslist.org/", "http://harrisonburg.craigslist.org/", "http://lynchburg.craigslist.org/", "http://blacksburg.craigslist.org/", "http://richmond.craigslist.org/", "http://roanoke.craigslist.org/", "http://swva.craigslist.org/", "http://winchester.craigslist.org/", "http://bellingham.craigslist.org/", "http://kpr.craigslist.org/", "http://moseslake.craigslist.org/", "http://olympic.craigslist.org/", "http://pullman.craigslist.org/", "http://seattle.craigslist.org/", "http://skagit.craigslist.org/", "http://spokane.craigslist.org/", "http://wenatchee.craigslist.org/", "http://yakima.craigslist.org/", "http://charlestonwv.craigslist.org/", "http://martinsburg.craigslist.org/", "http://huntington.craigslist.org/", "http://morgantown.craigslist.org/", "http://wheeling.craigslist.org/", "http://parkersburg.craigslist.org/", "http://swv.craigslist.org/", "http://wv.craigslist.org/", "http://appleton.craigslist.org/", "http://eauclaire.craigslist.org/", "http://greenbay.craigslist.org/", "http://janesville.craigslist.org/", "http://racine.craigslist.org/", "http://lacrosse.craigslist.org/", "http://madison.craigslist.org/", "http://milwaukee.craigslist.org/", "http://northernwi.craigslist.org/", "http://sheboygan.craigslist.org/", "http://wausau.craigslist.org/", "http://wyoming.craigslist.org/", "http://micronesia.craigslist.org/", "http://puertorico.craigslist.org/", "http://virgin.craigslist.org/"]
  