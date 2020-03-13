-- Big Things

CREATE TABLE IF NOT EXISTS BigThings(
    id TEXT PRIMARY KEY,
    name TEXT,
    location TEXT,
    year TEXT,
    status TEXT,
    latitude TEXT,
    longitude TEXT,
    image TEXT,
    rating TEXT,
    votes TEXT,
    updated TEXT,
    description TEXT,
    isRated INTEGER,
    isFavorited INTEGER
);

INSERT INTO "main"."BigThings" ("id", "name", "location", "year", "status", "latitude", "longitude", "image", "rating", "votes", "updated", "description") VALUES ('115', 'Map the Miner', 'Kapunda, South Australia, Australia', '1986', 'Active', '-34.3521', '138.9067', '0006.jpg', '6', '24', '2019-10-22', 'Map the Miner, also known as Map Kernow or the Son of Cornwall, is a 7-metre (23 ft) statue commemorating the Cornish mining history of the town of Kapunda in South Australia. Built by Ben van Zetten, the statue stands to at the southern entrance to the town, and is regarded as one of Australia''s Big Things. The statue was destroyed by fire in 2006, but it was rebuilt and rededicated 12 months later.');
INSERT INTO "main"."BigThings" ("id", "name", "location", "year", "status", "latitude", "longitude", "image", "rating", "votes", "updated", "description") VALUES ('3', 'Golden Gumboot', 'Tully, Queensland, Australia', '2003', 'Active', '-17.933811', '145.928061', '0003.jpg', '5', '1', '2019-10-22', 'The Golden Gumboot is a competition between the Far North Queensland towns of Tully, Innisfail, and Babinda in Australia for the wettest town of Australia. These towns are located in the Wet Tropics and on land that was previously covered by rainforest. These areas experience some of the highest levels of rainfall in Australia through monsoonal rain and cyclones. The winner for the competition (since 1970) was awarded a rubber boot. Despite the fact that Babinda has had more rainfall than Tully in the last 40 years, The Golden Gumboot monument was erected in Tully by the Tully Lions and Rotary Clubs on 10 May 2003. The project cost, including in-kind contributions, was $90,000. The official opening took place on 10 May 2003. The boot stands at 7.9 metres (25.9 ft) and represents the record rainfall for Tully in 1950. The boot is composed of fibreglass and has a spiral staircase to the top of the boot that allows a view of the town. Historical photographs of floods in the district are displayed on the walls inside the boot for visitors to view as they climb to the top. The Gumboot was designed, fabricated and installed by Brian Newell.');
INSERT INTO "main"."BigThings" ("id", "name", "location", "year", "status", "latitude", "longitude", "image", "rating", "votes", "updated", "description") VALUES ('9', 'Golden Guitar', 'Tamworth, New South Wales, Australia', '1988', 'Active', '-31.127458', '150.923442', '0009.jpg', '3', '2', '2019-10-22', 'The Golden Guitar was erected in front of the famous Longyard Hotel on the Sydney Road in 1988. It was unveiled by Australia''s most popular country music artist, Slim Dusty. Its location in Tamworth is symbolic of the city''s recognition and celebration of Australian country music, and its artists. The Golden Guitar stand approximately 12 metres high and weighs over 500 kilograms. It is constructed out of fibreglass and wood, with steel reinforcements. The Golden Guitar has no strings because it was modeled directly on the Golden Guitar trophies given to winners at the Country Music Awards of Australia ceremony night during the Tamworth Country Music Festival. ');
INSERT INTO "main"."BigThings" ("id", "name", "location", "year", "status", "latitude", "longitude", "image", "rating", "votes", "updated", "description") VALUES ('8', 'Big Rocking Horse', 'Gumeracha, South Australia, Australia', '1981', 'Active', '34.820991', '138.891842', '0008.jpg', '3.4', '5', '2019-10-22', 'Located in the town of Gumeracha, South Australia, the Big Rocking Horse was designed by David McIntosh. The structure weighs 25 tonnes and stands at over 18 metres tall. It is part of a larger complex that includes a wooden toy factory, wildlife park and cafe. Owned by the Wilkinson family since the early 1970s, the complex was sold in 2004 and continues to operate today. ');
INSERT INTO "main"."BigThings" ("id", "name", "location", "year", "status", "latitude", "longitude", "image", "rating", "votes", "updated", "description") VALUES ('4', 'Big Pineapple', 'Woombye, Queensland, Australia', '1971', 'Active', '-26.6708', '152.9926', '0004.jpg', '4', '6', '2019-10-22', 'The Big Pineapple is a heritage-listed tourist attraction at Nambour Connection Road, Woombye, Sunshine Coast Region, Queensland, Australia. It was designed by Peddle Thorp and Harvey, Paul Luff, and Gary Smallcombe and Associates. It is also known as Sunshine Plantation. It was added to the Queensland Heritage Register on 6 March 2009. The 2-level Big Pineapple is 16 metres (52 ft) high and was originally opened on 15 August 1971. It is situated on a 165-hectare (410-acre) site.');
INSERT INTO "main"."BigThings" ("id", "name", "location", "year", "status", "latitude", "longitude", "image", "rating", "votes", "updated", "description") VALUES ('7', 'Big Orange', 'Berri, South Australia, Australia', '1980', 'Inactive', '-34.246389', '140.620861', '0007.jpg', '3.6', '13', '2019-10-22', 'The Big Orange is one of a number of Big Things to be found in Australia, and is located near the Riverland town of Berri in South Australia. Standing at 15 metres in height, with a diameter of 12 metres, it is the biggest of the big fruit in Australia, and incorporates a cafe, souvenir shop, function room, lookout and a 360 degree mural within the structure. Opened in 1980, the landmark has at times struggled to find commercial success, changing hands in 2000, 2006 and again in 2008. Nevertheless, it has been described as the most defining icon of the region. The Big Orange is currently closed.');
INSERT INTO "main"."BigThings" ("id", "name", "location", "year", "status", "latitude", "longitude", "image", "rating", "votes", "updated", "description") VALUES ('2', 'Big Merino', 'Goulburn, New South Wales, Australia', '1985', 'Active', '-34.7726', '149.691', '0002.jpg', '3.7', '3', '2019-10-22', 'The Big Merino is a 15.2 metres (50 ft) tall concrete merino ram, containing a gift shop on the ground floor and a wool display on the second floor. Visitors can climb to the top and look out through the Merino''s eyes to view the local area. The Big Merino was officially opened on 20 September 1985. In 1992, the Hume Highway bypassed Goulburn, which resulted in a loss of 40 busloads of tourists to the Big Merino complex per day. On 26 May 2007, the Big Merino was moved to a location closer to the Hume Highway to increase visitor numbers, and is now located near the freeway interchange at a service station. ');
INSERT INTO "main"."BigThings" ("id", "name", "location", "year", "status", "latitude", "longitude", "image", "rating", "votes", "updated", "description") VALUES ('5', 'Big Lobster', 'Kingston SE, South Australia, Australia', '1979', 'Active', '-36.823778', '139.863194', '0005.jpg', '4.1', '9', '2019-10-22', 'The Big Lobster is located in the town of Kingston SE, South Australia. Known locally as Larry the Lobster, the sculpture of a spiny lobster stands 17 metres tall, and is regarded as one of the most impressive of Australia''s Big Things. Designed and built by Paul Kelly for Ian Backler and Rob Moyse, it is made of steel and fibreglass and was intended to attract attention to the restaurant and visitor centre at which it is situated. The Big Lobster was opened on 15 December 1979 after six months of construction. ');
INSERT INTO "main"."BigThings" ("id", "name", "location", "year", "status", "latitude", "longitude", "image", "rating", "votes", "updated", "description") VALUES ('1', 'Big Banana', 'Coffs Harbour, New South Wales, Australia', '1964', 'Active', '-30.274764', '153.133797', '0001.jpg', '3.9', '18', '2019-10-22', 'Built in 1964, the Big Banana was one of Australia''s first Big Things. Other attractions include a downhill toboggan ride, ice skating rink, a water park and the World of Bananas educational experience. Plantation tours are also available. In keeping with the plantation theme, banana-related products are shown or sold in the park which also boasts a souvenir shop and restaurant. In January 2014, during the peak tourist season the Big Banana received close to 150,000 visitors.');

PRAGMA USER_VERSION = 1;