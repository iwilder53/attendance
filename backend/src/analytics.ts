import { UserModel } from "./users/user";

const data =

    [{ "_id": "646f7b6647a5f0679541d23e", "roll": 9999, "subject": "TOC", "locationLat": "37.33022255", "locationLng": "-122.02795583", "createdAt": "2023-05-25T15:14:46.837Z", "updatedAt": "2023-05-25T15:14:46.837Z", "__v": 0 },
    { "_id": "646f7bae47a5f0679541d241", "roll": 9999, "subject": "TOC", "locationLat": "37.33084605", "locationLng": "-122.03054385", "createdAt": "2023-05-25T15:15:58.831Z", "updatedAt": "2023-05-25T15:15:58.831Z", "__v": 0 },
    { "_id": "646f7cb447a5f0679541d244", "roll": 9999, "subject": "TOC", "locationLat": "37.33010907", "locationLng": "-122.02221229", "createdAt": "2023-05-25T15:20:20.013Z", "updatedAt": "2023-05-25T15:20:20.013Z", "__v": 0 },
    { "_id": "646f7cbc47a5f0679541d247", "roll": 9999, "subject": "TOC", "locationLat": "37.33010907", "locationLng": "-122.02221229", "createdAt": "2023-05-25T15:20:28.879Z", "updatedAt": "2023-05-25T15:20:28.879Z", "__v": 0 },
    { "_id": "646f7e1f47a5f0679541d254", "roll": 9999, "subject": "TOC", "locationLat": "37.32520634", "locationLng": "-122.02507169", "createdAt": "2023-05-25T15:26:23.852Z", "updatedAt": "2023-05-25T15:26:23.852Z", "__v": 0 },
    { "_id": "646f818a47a5f0679541d25e", "roll": 9999, "subject": "TOC", "locationLat": "37.32459711", "locationLng": "-122.02469996", "createdAt": "2023-05-25T15:40:58.137Z", "updatedAt": "2023-05-25T15:40:58.137Z", "__v": 0 },
    { "_id": "646f819247a5f0679541d262", "roll": 12, "subject": "TOC", "semester": "2", "course": "Msc Computer science", "createdAt": "2023-05-25T15:41:06.502Z", "updatedAt": "2023-05-25T15:41:06.502Z", "__v": 0 },
    { "_id": "646f845e47a5f0679541d26f", "roll": 9999, "subject": "TOC", "locationLat": "37.32629715", "locationLng": "-122.01975275", "createdAt": "2023-05-25T15:53:02.103Z", "updatedAt": "2023-05-25T15:53:02.103Z", "__v": 0 },
    { "_id": "646f846247a5f0679541d273", "roll": 12, "subject": "TOC", "semester": "2", "course": "Msc Computer science", "createdAt": "2023-05-25T15:53:06.798Z", "updatedAt": "2023-05-25T15:53:06.798Z", "__v": 0 },
    { "_id": "646f850f47a5f0679541d27b", "roll": 9999, "subject": "TOC", "locationLat": "37.32459787", "locationLng": "-122.02477367", "createdAt": "2023-05-25T15:55:59.016Z", "updatedAt": "2023-05-25T15:55:59.016Z", "__v": 0 },
    { "_id": "646f853447a5f0679541d27e", "roll": 9999, "subject": "TOC", "locationLat": "37.32561029", "locationLng": "-122.02508986", "createdAt": "2023-05-25T15:56:36.343Z", "updatedAt": "2023-05-25T15:56:36.343Z", "__v": 0 },
    { "_id": "646f853647a5f0679541d282", "roll": 12, "subject": "TOC", "semester": "2", "course": "BSC IT II", "createdAt": "2023-05-25T15:56:38.770Z", "updatedAt": "2023-05-25T15:56:38.770Z", "__v": 0 },
    { "_id": "6471bce747a5f0679541d289", "roll": 9999, "subject": "TOC", "locationLat": "37.32563464", "locationLng": "-122.01972943", "createdAt": "2023-05-27T08:18:47.722Z", "updatedAt": "2023-05-27T08:18:47.722Z", "__v": 0 },
    { "_id": "6471bd0247a5f0679541d28d", "roll": 5, "subject": "TOC", "semester": "2", "course": "Msc Computer science", "createdAt": "2023-05-27T08:19:14.703Z", "updatedAt": "2023-05-27T08:19:14.703Z", "__v": 0 },
    { "_id": "6471bd9347a5f0679541d290", "roll": 9999, "subject": "TOC", "locationLat": "37.32488549", "locationLng": "-122.02507594", "createdAt": "2023-05-27T08:21:39.992Z", "updatedAt": "2023-05-27T08:21:39.992Z", "__v": 0 },
    { "_id": "6471bdae913adffb97b29a83", "roll": 5, "subject": "TOC", "semester": "2", "course": "BCA II", "createdAt": "2023-05-27T08:22:06.008Z", "updatedAt": "2023-05-27T08:22:06.008Z", "__v": 0 },
    { "_id": "6471be2e913adffb97b29a86", "roll": 9999, "subject": "DMS", "locationLat": "37.32896226", "locationLng": "-122.02686689", "createdAt": "2023-05-27T08:24:14.630Z", "updatedAt": "2023-05-27T08:24:14.630Z", "__v": 0 },
    { "_id": "6471c0ac913adffb97b29a8b", "roll": 9999, "subject": "TOC", "locationLat": "21.1652725", "locationLng": "79.0798636", "createdAt": "2023-05-27T08:34:52.388Z", "updatedAt": "2023-05-27T08:34:52.388Z", "__v": 0 },
    { "_id": "65c887d19850158f3cf8d04a", "roll": 9999, "subject": "DMS", "locationLat": "37.32896226", "locationLng": "-122.02686689", "createdAt": "2023-05-27T08:24:14.630Z", "updatedAt": "2023-05-27T08:24:14.630Z", "__v": 0 },
    { "_id": "65c887d39850158f3cf8d04b", "roll": 9999, "subject": "DMS", "locationLat": "37.32896226", "locationLng": "-122.02686689", "createdAt": "2023-05-27T08:24:14.630Z", "updatedAt": "2023-05-27T08:24:14.630Z", "__v": 0 },
    { "_id": "65c887d69850158f3cf8d04c", "roll": 9999, "subject": "DMS", "locationLat": "37.32896226", "locationLng": "-122.02686689", "createdAt": "2023-05-27T08:24:14.630Z", "updatedAt": "2023-05-27T08:24:14.630Z", "__v": 0 },
    { "_id": "65c887d99850158f3cf8d04d", "roll": 9999, "subject": "DMS", "locationLat": "37.32896226", "locationLng": "-122.02686689", "createdAt": "2023-05-27T08:24:14.630Z", "updatedAt": "2023-05-27T08:24:14.630Z", "__v": 0 },
    { "_id": "65ef48185354928abf0cc5bb", "roll": 21, "subject": "TOC", "locationLat": "37.32589048", "locationLng": "-122.0255808", "createdAt": "2024-03-11T18:06:16.098Z", "updatedAt": "2024-03-11T18:06:16.098Z", "__v": 0 },
    { "_id": "65ef48765354928abf0cc5be", "roll": 21, "subject": "TOC", "locationLat": "37.32830924", "locationLng": "-122.02685755", "createdAt": "2024-03-11T18:07:50.770Z", "updatedAt": "2024-03-11T18:07:50.770Z", "__v": 0 },
    { "_id": "65ef48a45354928abf0cc5c1", "roll": 21, "subject": "CG", "locationLat": "37.32994938", "locationLng": "-122.02684691", "createdAt": "2024-03-11T18:08:36.960Z", "updatedAt": "2024-03-11T18:08:36.960Z", "__v": 0 },
    { "_id": "65ef68d9b3dfd68136b0542d", "roll": 21, "subject": "CG", "locationLat": "37.33069273", "locationLng": "-122.02971484", "createdAt": "2024-03-11T20:26:01.463Z", "updatedAt": "2024-03-11T20:26:01.463Z", "__v": 0 },
    { "_id": "65ef68e1b3dfd68136b05430", "roll": 21, "subject": "CAO", "locationLat": "37.33069543", "locationLng": "-122.02933632", "createdAt": "2024-03-11T20:26:09.292Z", "updatedAt": "2024-03-11T20:26:09.292Z", "__v": 0 },
    { "_id": "65f0079426a7994ffda5b90f", "roll": 21, "subject": "CG", "locationLat": "37.32983646", "locationLng": "-122.02014032", "createdAt": "2024-03-12T07:43:16.451Z", "updatedAt": "2024-03-12T07:43:16.451Z", "__v": 0 }]

const students = data.map((e) => e.roll).sort();

let temp: any[] = data.filter((e) => e.course);

interface TimetableEntry {
    course?: string;
    roll: number;
}


function findMostOccurringRoll(entries: TimetableEntry[]): any {
    const rollCounts: { [roll: number]: number } = {};

    // Count occurrences of each roll
    entries.forEach(entry => {
        if (rollCounts[entry.roll]) {
            rollCounts[entry.roll]++;
        } else {
            rollCounts[entry.roll] = 1;
        }
    });

    let mostOccurringRoll: number = 0;
    let maxOccurrences: number = 0;

    // Find the roll with the maximum occurrences
    Object.entries(rollCounts).forEach(([roll, count]) => {
        if (count > maxOccurrences) {
            maxOccurrences = count;
            mostOccurringRoll = parseInt(roll);
        }
    });

    return rollCounts;
}


function countEntriesWithCourse(entries: TimetableEntry[]): number {
    let count = 0;

    entries.forEach(entry => {
        if (entry.course !== undefined) {
            count++;
        }
    });

    return count;
}




console.log(findMostOccurringRoll(data))


//TODO;
//get number of entries from tt table
//get