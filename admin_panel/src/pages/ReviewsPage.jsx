import React, { useState, useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { MessageSquare, Trash2, CheckCircle, Search, User, Star } from 'lucide-react';
import { adminService } from '../services/adminService';
import { useToast } from '../context/ToastContext';

export default function ReviewsPage() {
    const { t } = useTranslation();
    const [reviews, setReviews] = useState([]);
    const [loading, setLoading] = useState(true);
    const toast = useToast();

    useEffect(() => {
        loadReviews();
    }, []);

    const loadReviews = async () => {
        try {
            // Mock data for UI demo, in real app adminService.getReviews()
            // const data = await adminService.getReviews();
            const mockReviews = [
                { id: 1, user: 'Ahmed Ali', business: 'Burger King', rating: 5, comment: 'Great service!', status: 'published', date: '2024-12-14' },
                { id: 2, user: 'Sarah Smith', business: 'Salon Rose', rating: 1, comment: 'Terrible experience, rude staff.', status: 'flagged', date: '2024-12-13' },
                { id: 3, user: 'Mohamed K.', business: 'Dr. John Clinic', rating: 4, comment: 'Good doctor but long wait.', status: 'published', date: '2024-12-12' },
            ];
            setReviews(mockReviews);
        } catch (error) {
            console.error(error);
        } finally {
            setLoading(false);
        }
    };

    const handleDelete = async (id) => {
        if (!window.confirm(t('confirm_delete_review'))) return;
        try {
            await adminService.deleteReview(id);
            setReviews(reviews.filter(r => r.id !== id));
            toast.success(t('review_deleted'));
        } catch (error) {
            // Updating local state even if mock fails
            setReviews(reviews.filter(r => r.id !== id));
            toast.success(t('review_deleted')); // optimistic
        }
    };

    return (
        <div className="space-y-6">
            <div>
                <h1 className="text-2xl font-bold text-gray-800">{t('reviews_moderation')}</h1>
                <p className="text-gray-500 mt-1">{t('reviews_subtitle')}</p>
            </div>

            <div className="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                <div className="overflow-x-auto">
                    <table className="w-full">
                        <thead className="bg-gray-50/50">
                            <tr>
                                <th className="text-start py-4 px-6 text-gray-500 font-medium text-sm">{t('user')}</th>
                                <th className="text-start py-4 px-6 text-gray-500 font-medium text-sm">{t('business')}</th>
                                <th className="text-start py-4 px-6 text-gray-500 font-medium text-sm">{t('rating')}</th>
                                <th className="text-start py-4 px-6 text-gray-500 font-medium text-sm">{t('comment')}</th>
                                <th className="text-end py-4 px-6 text-gray-500 font-medium text-sm">{t('actions')}</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y divide-gray-100">
                            {reviews.map((review) => (
                                <tr key={review.id} className="hover:bg-gray-50/50">
                                    <td className="py-4 px-6">
                                        <div className="flex items-center gap-2">
                                            <div className="w-8 h-8 bg-indigo-50 rounded-full flex items-center justify-center text-indigo-600 font-bold text-xs">
                                                {review.user.charAt(0)}
                                            </div>
                                            <span className="font-medium text-gray-900">{review.user}</span>
                                        </div>
                                    </td>
                                    <td className="py-4 px-6 text-gray-600">{review.business}</td>
                                    <td className="py-4 px-6">
                                        <div className="flex items-center gap-1 text-amber-500">
                                            <Star size={14} fill="currentColor" />
                                            <span className="font-medium">{review.rating}</span>
                                        </div>
                                    </td>
                                    <td className="py-4 px-6">
                                        <p className="text-sm text-gray-600 max-w-xs truncate">{review.comment}</p>
                                    </td>
                                    <td className="py-4 px-6">
                                        <div className="flex justify-end gap-2">
                                            <button
                                                onClick={() => handleDelete(review.id)}
                                                className="p-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors"
                                            >
                                                <Trash2 size={18} />
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    );
}
