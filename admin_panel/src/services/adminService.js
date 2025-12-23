import { db } from '../firebase';
import { collection, addDoc, getDocs, doc, deleteDoc, updateDoc, query, orderBy, where } from 'firebase/firestore';

export const adminService = {
    /**
     * Send a push notification to all users or specific segment
     * Note: In a real app, this would call a Cloud Function.
     * Here we simulate it by writing to a 'notifications' collection or 'campaigns'
     */
    sendNotification: async (notificationData) => {
        try {
            await addDoc(collection(db, 'notifications_queue'), {
                ...notificationData,
                status: 'pending',
                createdAt: new Date()
            });
            return { success: true };
        } catch (error) {
            console.error("Error sending notification:", error);
            throw error;
        }
    },

    /**
     * Get all reviews for moderation
     */
    getReviews: async () => {
        try {
            const q = query(collection(db, 'reviews'), orderBy('createdAt', 'desc'));
            const snapshot = await getDocs(q);
            return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
        } catch (error) {
            console.error("Error getting reviews:", error);
            throw error;
        }
    },

    /**
     * Delete an inappropriate review
     */
    deleteReview: async (reviewId) => {
        try {
            await deleteDoc(doc(db, 'reviews', reviewId));
        } catch (error) {
            console.error("Error deleting review:", error);
            throw error;
        }
    },

    /**
     * Get system logs
     */
    getLogs: async () => {
        // Mock logs for now
        return [
            { id: 1, action: 'User Login', user: 'admin@taabor.com', time: '2 mins ago', type: 'info' },
            { id: 2, action: 'Business Approved', user: 'admin@taabor.com', time: '1 hour ago', type: 'success' },
            { id: 3, action: 'Failed Login Attempt', user: 'unknown', time: '3 hours ago', type: 'warning' },
        ];
    }
};
