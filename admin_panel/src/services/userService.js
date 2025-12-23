import { db } from '../firebase';
import { collection, getDocs, addDoc, doc, updateDoc, deleteDoc, query, orderBy, setDoc } from 'firebase/firestore';

const COLLECTION_NAME = 'users';

export const userService = {
    /**
     * Fetch all users from Firestore
     * @returns {Promise<Array>} List of users
     */
    getUsers: async () => {
        try {
            const q = query(collection(db, COLLECTION_NAME), orderBy('createdAt', 'desc'));
            const querySnapshot = await getDocs(q);
            return querySnapshot.docs.map(doc => ({
                id: doc.id,
                ...doc.data()
            }));
        } catch (error) {
            console.error("Error fetching users:", error);
            // Fallback to simple fetch if index is missing
            if (error.code === 'failed-precondition') {
                const querySnapshot = await getDocs(collection(db, COLLECTION_NAME));
                return querySnapshot.docs.map(doc => ({
                    id: doc.id,
                    ...doc.data()
                }));
            }
            throw error;
        }
    },

    /**
     * Add a new user
     * @param {Object} userData 
     * @returns {Promise<Object>} The created user with ID
     */
    addUser: async (userData) => {
        try {
            const docRef = await addDoc(collection(db, COLLECTION_NAME), {
                ...userData,
                createdAt: new Date(),
                lastActive: new Date(),
                status: 'Active'
            });
            return { id: docRef.id, ...userData };
        } catch (error) {
            console.error("Error adding user:", error);
            throw error;
        }
    },

    /**
     * Add a new user with specific ID (for Auth Sync)
     * @param {String} uid
     * @param {Object} userData 
     */
    addUserWithId: async (uid, userData) => {
        try {
            const userRef = doc(db, COLLECTION_NAME, uid);
            await setDoc(userRef, {
                ...userData,
                createdAt: new Date(),
                lastActive: new Date(),
                status: 'Active' // Default status
            });
        } catch (error) {
            console.error("Error adding user with ID:", error);
            throw error;
        }
    },

    /**
     * Update a user
     * @param {String} userId 
     * @param {Object} data 
     */
    updateUser: async (userId, data) => {
        try {
            const userRef = doc(db, COLLECTION_NAME, userId);
            await updateDoc(userRef, data);
        } catch (error) {
            console.error("Error updating user:", error);
            throw error;
        }
    },

    /**
     * Delete a user
     * @param {String} userId 
     */
    deleteUser: async (userId) => {
        try {
            await deleteDoc(doc(db, COLLECTION_NAME, userId));
        } catch (error) {
            console.error("Error deleting user:", error);
            throw error;
        }
    }
};
