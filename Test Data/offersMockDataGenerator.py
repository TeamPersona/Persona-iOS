import argparse   # Argument parsing
import json       # JSON encoding
import os         # Create/Delete directory
import math       # Math
import random     # Random numbers
import datetime   # Dates

# Argument Parser for this program.
parser = argparse.ArgumentParser(description="Persona offers mock data generator.")
parser.add_argument("numOffers", metavar="n", type=int, help="number of offers to generate")
parser.add_argument("paginateLimit", metavar="p", nargs="?", type=int, help="(optional) number of offers per page")
parser.add_argument("output", metavar="output", nargs="?", type=str, default="generated_offers", help="output directory name")
parser.add_argument("-u", "--userInfo", help="outputs the randomly generated the user's missing info", action="store_true")
args = parser.parse_args()

# Global variables.
randBool = [True, False]
# Epoch base datetime.
epoch = datetime.datetime.utcfromtimestamp(0)
# Start date.
startDate = datetime.datetime(2016, 2, 16, 0, 0)
# End date.
endDate = datetime.datetime(2016, 3, 8, 0, 0)
currentDate = (datetime.datetime.now() - epoch).total_seconds()

weightedRanks = [0] * 11 + [1] * 7 + [2] * 2            # (divided by 5 - weights are 55%, 35%, 10%, respectively)
weighted10Chance = [True] * 3 + [False] * 17            # (15% chance)
weighted20Chance = [True] + [False] * 4                 # (20% chance)
weighted40Chance = [True] * 2 + [False] * 3             # (40% chance)

# Load partners list as an array.
with open('partnersList.json' ,'r') as f:
    partners = json.load(f)['partners']
# List of some offer details.
offerDetailsList = ["Get 20% off your next purchase!",
                    "Get 30% off your next purchase!",
                    "Get 40% off your next purchase!",
                    "Get 50% off your next purchase!",
                    "Get 60% off your next purchase!",
                    "Get 70% off your next purchase!",
                    "Get 80% off your next purchase!",
                    "Buy one get one free!",
                    "Buy two get one free!",
                    "Buy one get one 40% off!",
                    "Buy one get one 50% off!",
                    "Buy one get one 60% off!",
                    "Join our membership and get 10% off your next purchase!",
                    "Join our membership and get 20% off your next purchase!",
                    "Join our membership and get 30% off your next purchase!",
                    "Join our membership and get 40% off your next purchase!",
                    "Join our membership and get 50% off your next purchase!",
                    "Participate now and receive our limited time offer!",
                    "$5 off your first order!",
                    "$10 off your first order!",
                    "$20 off your first order!",
                    "$30 off your first order!"
                    ]

informationTypesCategoryList = {"Basic" : ["First Name", "Last Name", "Date of Birth", "Gender", "Ethnicity", "Home Address", "Allow Contact"],
                                "Personal" : ["Education", "Marital Status", "Number of Dependents", "Political Affliations", "Religion"],
                                "Financial" : ["Salary", "Purchase History", "Credit Score"],
                                "Employment" : ["Current Employer", "Employment History"],
                                "Heath & Fitness" : ["Height", "Weight", "Has Eyewear", "Disabilities", "Medical History", "Steps Taken History", "Sleep Tracking History"],
                                "Entertainment" : ["TV Shows Interests", "Movie Interests", "Book Interests", "Favorite Sports Teams", "Video Game Interests", ],
                                "Social" : ["Facebook Friends List", "Facebook Statuses", "Facebook Events", "Twitter Following List", "Twitter Followers List",
                                            "Twitter Favorties", "Twitter Retweets", "Instagram Following List", "Instagram Followers List", "Instagram Photos",
                                            "Swarm Check-ins", "Yelp Reviews"]
                               }

# Randomly pick which information the user is missing.
missingInformationTypesList = {}
for k in informationTypesCategoryList.keys():
    for info in informationTypesCategoryList[k]:
        isMissing = random.choice(weighted10Chance)
        if k in missingInformationTypesList:
            missingInformationTypesList[k].append(isMissing)
        else:
            missingInformationTypesList[k] = [isMissing]

def random_date(start, end):
    """Returns a random datetime between two datetimes."""
    dt = end - start
    delta = dt.days * 24 * 60 * 60 + dt.seconds
    return start + datetime.timedelta(seconds=random.randrange(delta))

def determine_offer_status(d1, d2, currP, maxP):
    if random.choice(weighted20Chance):
        return 5

    if currentDate < d1:
        return 1
    elif currentDate >= d1 and currentDate < d2:
        if currP == maxP:
            return 2
        else:
            return 4
    elif currentDate >= currentDate:
        return 3

def determine_is_participating(offerStatus, isEligible):
    if offerStatus == 1 or not isEligible:
        return False
    else:
        return random.choice(weighted40Chance)

def diff_info(a, b):
    """Returns A - B of info dictionarys."""
    r = {}
    for k in a.keys():
        if k in b.keys():
            r[k] = [aa for aa in a[k] if aa not in b[k]]
        else:
            r[k] = a[k]
    return r

def has_missing_info(info):
    for k in info.keys():
        for v in info[k]:
            if v['informationMissing']:
                return True

def generate_random_info():
    info = {}
    filtersCount = random.randint(2, 6)
    for i in range(0, filtersCount):
        k = random.choice(list(informationTypesCategoryList.keys()))
        index = random.randint(0, len(informationTypesCategoryList[k]) - 1)
        v = informationTypesCategoryList[k][index]
        obj = {'informationType' : v, 'informationMissing' : missingInformationTypesList[k][index]}
        if k in info:
            if obj not in info[k]:
                info[k].append(obj)
        else:
            info[k] = [obj]
    return info

def write_out_user_info():
    r = {}
    for k in informationTypesCategoryList.keys():
        r[k] = []
        for i in range(0, len(informationTypesCategoryList[k])):
            r[k].append({'informationType' : informationTypesCategoryList[k][i], 'informationMissing' : missingInformationTypesList[k][i]})
    with open('./' + args.output + '/userMissingInfo.json', 'w') as out:
            json.dump({'userMissingInfo' : r}, out, sort_keys=True, indent=2, ensure_ascii=False)

def generate_random_offer(lastOfferId, lastMessageId):
    """Returns a random generated offer."""
    offer = {}
    # Add random partner data.
    offer.update(partners[random.randint(0, len(partners)-1)])
    # Increment offer id by random amount from 1 to 100.
    lastOfferId += random.randint(1, 100)
    offer['offerId'] = lastOfferId
    offer['offerDetails'] = random.choice(offerDetailsList)
    offer['offerReward'] = round(random.uniform(0, 10), 2)
    randomStartDate = random_date(startDate, endDate)
    offer['offerStartDate'] =  int((randomStartDate - epoch).total_seconds())
    offer['offerExpirationDate'] =  int((random_date(randomStartDate, endDate) - epoch).total_seconds())
    offer['offerMaxParticipants'] = random.randint(1, 50) * 10
    offer['offerCurrentParticipants'] = random.randint(0, offer['offerMaxParticipants'])
    offer['offerFilters'] = generate_random_info()
    offer['offerInfoRequired'] = diff_info(generate_random_info(), offer['offerFilters'])
    offer['offerStatus'] = determine_offer_status(offer['offerStartDate'], offer['offerExpirationDate'], offer['offerCurrentParticipants'], offer['offerMaxParticipants'])
    offer['offerMinRank'] = random.choice(weightedRanks)
    offer['isEligible'] = not has_missing_info(offer['offerFilters']) and not has_missing_info(offer['offerInfoRequired'])
    offer['isParticipating'] = determine_is_participating(offer['offerStatus'], offer['isEligible'])
    if random.choice(randBool) and offer['offerStatus'] == 3:
        lastMessageId += random.randint(1, 100)
        offer['messageId'] = lastMessageId
        offer['didReadMessage'] = random.choice(randBool)
    return [offer, lastOfferId, lastMessageId]

# Create the directory to place the output.
outputPath = "./" + args.output
os.makedirs(outputPath, exist_ok=True)
fileList = [f for f in os.listdir(outputPath) if f.startswith("offers") and f.endswith(".json")]
for f in fileList:
    os.remove(outputPath + "/" + f)

# Output the user's missing info.
if args.userInfo:
    write_out_user_info()

# Initialize data to encode to JSON.
data = {}
lastOfferId = 0
lastMessageId = 0

if args.paginateLimit:
    count = 0
    numPages = math.ceil(args.numOffers / args.paginateLimit)
    for i in range(0, numPages):
        data.update({'page' : i, 'lastOfferId' : lastOfferId, 'offers' : []})
        for j in range(0, min(args.numOffers - count, args.paginateLimit)):
            r = generate_random_offer(lastOfferId, lastMessageId)
            data['offers'].append(r[0])
            lastOfferId = r[1]
            lastMessageId = r[2]
            count += 1
        # Write out JSON page.
        with open('./' + args.output + '/offers' + str(i) + '.json', 'w') as out:
            json.dump(data, out, sort_keys=True, indent=2, ensure_ascii=False)
else:
    data = {'offers' : []}
    for i in range(0, args.numOffers):
        r = generate_random_offer(lastOfferId, lastMessageId)
        data['offers'].append(r[0])
        lastOfferId = r[1]
        lastMessageId = r[2]
    # Write out JSON page.
    with open('./' + args.output + '/offers.json', 'w') as out:
        json.dump(data, out, sort_keys=True, indent=2, ensure_ascii=False)