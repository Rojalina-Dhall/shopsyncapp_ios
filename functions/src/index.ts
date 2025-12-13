/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import {setGlobalOptions} from "firebase-functions";
import * as admin from "firebase-admin";
// import * as functions from "firebase-functions";
import { onCall, CallableRequest, HttpsError } from "firebase-functions/v2/https";
//import * as logger from "firebase-functions/logger";



admin.initializeApp();



// Start writing functions
// https://firebase.google.com/docs/functions/typescript

// For cost control, you can set the maximum number of containers that can be
// running at the same time. This helps mitigate the impact of unexpected
// traffic spikes by instead downgrading performance. This limit is a
// per-function limit. You can override the limit for each function using the
// `maxInstances` option in the function's options, e.g.
// `onRequest({ maxInstances: 5 }, (req, res) => { ... })`.
// NOTE: setGlobalOptions does not apply to functions using the v1 API. V1
// functions should each use functions.runWith({ maxInstances: 10 }) instead.
// In the v1 API, each function can only serve one request per container, so
// this will be the maximum concurrent request count.
setGlobalOptions({ maxInstances: 10 });

// export const helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
export const helloWorld = onCall(
  (request: CallableRequest<{ name: string }>) => {
    const name = request.data?.name ?? "Unknown"; // access via .data



  return {
    message: `Hello from Firebase Functions!`,
    receivedName: name
  };
});


// export const createUserAccount = onCall(async (request) => {
//   const { email, password} = request.data;

//   if (!email || !password) {
//     throw new HttpsError("invalid-argument", "Missing email or password");
//   }

//   try {
//     const userRecord = await admin.auth().createUser({ email, password });
//     return { status: "success", uid: userRecord.uid };
//   } catch (error: any) {
//     console.error("❌ FUNCTION ERROR:", error);
//     throw new HttpsError("internal", error.message);
//   }
// });


export const createUserAccount = onCall(async (request) => {
  const { email, password, name, city } = request.data;

  if (!email || !password || !name || !city) {
    throw new HttpsError(
      "invalid-argument",
      "Missing required fields: email, password, name, city."
    );
  }

  try {
    // 1️⃣ Create Auth user
    const userRecord = await admin.auth().createUser({ email, password });
    const uid = userRecord.uid;

    // 2️⃣ Create Firestore document
    await admin.firestore().collection("users").doc(uid).set({
      id: uid,
      name,
      email,
      city,
      createdAt: admin.firestore.Timestamp.now(),
    });

    return { status: "success", uid };
  } catch (error: any) {
    console.error("❌ FUNCTION ERROR:", error);
    throw new HttpsError("internal", error.message);
  }
});