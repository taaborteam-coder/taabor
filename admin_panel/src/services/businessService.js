import { db } from '../firebase';
import { collection, getDocs, addDoc, doc, updateDoc, deleteDoc, query, orderBy, setDoc } from 'firebase/firestore';

const COLLECTION_NAME = 'businesses';

export const businessService = {
    /**
     * Fetch all businesses from Firestore
     */
    getBusinesses: async () => {
        try {
            const q = query(collection(db, COLLECTION_NAME), orderBy('createdAt', 'desc'));
            const querySnapshot = await getDocs(q);
            return querySnapshot.docs.map(doc => ({
                id: doc.id,
                ...doc.data()
            }));
        } catch (error) {
            console.error("Error fetching businesses:", error);
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
     * Add a new business
     */
    addBusiness: async (businessData) => {
        try {
            const docRef = await addDoc(collection(db, COLLECTION_NAME), {
                ...businessData,
                createdAt: new Date(),
                status: businessData.status || 'Pending'
            });
            return { id: docRef.id, ...businessData };
        } catch (error) {
            console.error("Error adding business:", error);
            throw error;
        }
    },

    /**
     * Update a business
     */
    updateBusiness: async (businessId, data) => {
        try {
            const businessRef = doc(db, COLLECTION_NAME, businessId);
            await updateDoc(businessRef, data);
        } catch (error) {
            console.error("Error updating business:", error);
            throw error;
        }
    },

    /**
     * Delete a business
     */
    deleteBusiness: async (businessId) => {
        try {
            await deleteDoc(doc(db, COLLECTION_NAME, businessId));
        } catch (error) {
            console.error("Error deleting business:", error);
            throw error;
        }
    }
};
