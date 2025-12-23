import React, { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { collection, query, where, onSnapshot, getDocs } from 'firebase/firestore';
import { db } from '../firebase';
import { Loader2, Users, Clock, AlertCircle } from 'lucide-react';

export default function QueuePage() {
    const { t } = useTranslation();
    const [queues, setQueues] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        // Real-time listener for active queues
        const q = query(
            collection(db, 'queues'),
            where('status', '==', 'active')
        );

        const unsubscribe = onSnapshot(q, async (snapshot) => {
            const queueList = [];

            // We need to fetch business names for each queue
            // In a real app, you might denormalize this data or use a join query 
            // (not natively supported in Firestore but simulated here)

            for (const doc of snapshot.docs) {
                const data = doc.data();
                let businessName = 'Unknown Business';

                if (data.businessId) {
                    // This is inefficient for many queues, but fine for admin dashboard
                    // Optimization: Cache business names or store name in queue doc
                    try {
                        const businessSnapshot = await getDocs(query(collection(db, 'businesses'), where('__name__', '==', data.businessId)));
                        if (!businessSnapshot.empty) {
                            businessName = businessSnapshot.docs[0].data().name;
                        }
                    } catch (e) {
                        console.error("Error fetching business name", e);
                    }
                }

                queueList.push({
                    id: doc.id,
                    ...data,
                    businessName
                });
            }

            setQueues(queueList);
            setLoading(false);
        });

        return () => unsubscribe();
    }, []);

    if (loading) {
        return (
            <div className="flex justify-center items-center h-full">
                <Loader2 className="w-8 h-8 animate-spin text-indigo-600" />
            </div>
        );
    }

    return (
        <div className="space-y-6">
            <div>
                <h1 className="text-2xl font-bold text-gray-800">{t('live_queues')}</h1>
                <p className="text-gray-500 mt-1">{t('monitor_active_queues')}</p>
            </div>

            {queues.length === 0 ? (
                <div className="bg-white rounded-2xl p-10 text-center shadow-sm border border-gray-100">
                    <div className="w-16 h-16 bg-gray-50 rounded-full flex items-center justify-center mx-auto mb-4">
                        <Clock size={32} className="text-gray-300" />
                    </div>
                    <h3 className="text-lg font-semibold text-gray-900 mb-1">{t('no_active_queues')}</h3>
                    <p className="text-gray-500">{t('queues_will_appear_here')}</p>
                </div>
            ) : (
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    {queues.map((queue) => (
                        <div key={queue.id} className="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 relative overflow-hidden">
                            <div className="absolute top-0 right-0 w-24 h-24 bg-indigo-50 rounded-bl-full -mr-4 -mt-4 opacity-50"></div>

                            <div className="relative z-10">
                                <h3 className="font-bold text-lg text-gray-900 mb-1 truncate">{queue.businessName}</h3>
                                <p className="text-sm text-gray-500 mb-4">{queue.name || 'General Queue'}</p>

                                <div className="grid grid-cols-2 gap-4 mb-4">
                                    <div className="bg-indigo-50 rounded-xl p-3 text-center">
                                        <p className="text-xs text-indigo-600 font-medium mb-1">{t('serving_now')}</p>
                                        <p className="text-2xl font-bold text-indigo-700">{queue.currentTicket || '-'}</p>
                                    </div>
                                    <div className="bg-gray-50 rounded-xl p-3 text-center">
                                        <p className="text-xs text-gray-500 font-medium mb-1">{t('waiting')}</p>
                                        <p className="text-2xl font-bold text-gray-700">{queue.waitingCount || 0}</p>
                                    </div>
                                </div>

                                <div className="flex items-center justify-between text-xs text-gray-400 border-t pt-4 border-gray-100">
                                    <div className="flex items-center gap-1">
                                        <Users size={14} />
                                        <span>Total: {queue.totalTickets || 0}</span>
                                    </div>
                                    <div className="flex items-center gap-1">
                                        <Clock size={14} />
                                        <span>Avg: {queue.avgWaitTime || '5'} min</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    ))}
                </div>
            )}
        </div>
    );
}
