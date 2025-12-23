import { db } from '../firebase';
import { collection, getDocs, query, where, orderBy, limit } from 'firebase/firestore';

export const analyticsService = {
    /**
     * Fetch and calculate dashboard statistics
     */
    getDashboardStats: async () => {
        try {
            const stats = {
                totalRevenue: 0,
                activeSessions: 0,
                revenueGrowth: 12.5, // Mock for now
                sessionGrowth: 5.2,  // Mock for now
                monthlyRevenue: [],
                userGrowth: [],
                categoryDistribution: []
            };

            // 1. Calculate Revenue & Sessions from Queue
            const queueSnapshot = await getDocs(collection(db, 'queue'));
            let completedCount = 0;

            queueSnapshot.forEach(doc => {
                const data = doc.data();
                if (data.status === 'completed') {
                    completedCount++;
                } else if (['waiting', 'serving'].includes(data.status)) {
                    stats.activeSessions++;
                }
            });

            // Assume 50 SAR per completed transaction
            stats.totalRevenue = completedCount * 50;

            // 2. Category Distribution from Businesses
            const businessSnapshot = await getDocs(collection(db, 'businesses'));
            const categories = {};

            businessSnapshot.forEach(doc => {
                const cat = doc.data().category || 'Other';
                categories[cat] = (categories[cat] || 0) + 1;
            });

            stats.categoryDistribution = Object.entries(categories).map(([name, value]) => ({
                name,
                value
            }));

            // 3. User Growth (Last 7 Days) - Simplified
            // Ideally we'd query by date, but client-side filter is fine for small scale
            const usersSnapshot = await getDocs(query(collection(db, 'users'), orderBy('createdAt', 'desc'), limit(100)));
            const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
            const growthMap = {};

            usersSnapshot.forEach(doc => {
                const createdAt = doc.data().createdAt?.toDate ? doc.data().createdAt.toDate() : new Date();
                const dayName = days[createdAt.getDay()];
                growthMap[dayName] = (growthMap[dayName] || 0) + 1;
            });

            // Fill in last 7 days order
            const today = new Date().getDay();
            stats.userGrowth = [];
            for (let i = 6; i >= 0; i--) {
                const dIndex = (today - i + 7) % 7;
                const dayName = days[dIndex];
                stats.userGrowth.push({
                    name: dayName,
                    users: growthMap[dayName] || 0 // This is just "new users that day", cumulative is harder without more data
                });
            }

            // Mock Monthly Revenue for Chart (random variation around total)
            stats.monthlyRevenue = [
                { name: 'Jan', value: stats.totalRevenue * 0.1 },
                { name: 'Feb', value: stats.totalRevenue * 0.15 },
                { name: 'Mar', value: stats.totalRevenue * 0.12 },
                { name: 'Apr', value: stats.totalRevenue * 0.2 },
                { name: 'May', value: stats.totalRevenue * 0.18 },
                { name: 'Jun', value: stats.totalRevenue * 0.25 },
            ];

            return stats;

        } catch (error) {
            console.error("Error fetching analytics:", error);
            throw error;
        }
    }
};
