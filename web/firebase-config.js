// Firebase configuration for web
const firebaseConfig = {
  apiKey: "AIza-demo-key-replace-with-real",
  authDomain: "mobile-app-location-demo.firebaseapp.com",
  projectId: "mobile-app-location-demo",
  storageBucket: "mobile-app-location-demo.appspot.com",
  messagingSenderId: "123456789",
  appId: "1:123456789:web:abcdef123456"
};

// Initialize Firebase
import { initializeApp } from 'firebase/app';
const app = initializeApp(firebaseConfig);
