// Firebase configuration for web
const firebaseConfig = {
  apiKey: "AIzaSyCvSnYEIuPUNfSNJrj5vpSFjcaX24YEsM4",
  authDomain: "mobile-app-location-b5ce8.firebaseapp.com",
  databaseURL: "https://mobile-app-location-b5ce8-default-rtdb.asia-southeast1.firebasedatabase.app",
  projectId: "mobile-app-location-b5ce8",
  storageBucket: "mobile-app-location-b5ce8.firebasestorage.app",
  messagingSenderId: "1018454247619",
  appId: "1:1018454247619:web:0df27e4eb2979fd6bafa76",
  measurementId: "G-SRFPRP32XM"
};

// Initialize Firebase
import { initializeApp } from 'firebase/app';
const app = initializeApp(firebaseConfig);
