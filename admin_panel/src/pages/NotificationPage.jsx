import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Send, Bell, Users, Clock, AlertTriangle } from 'lucide-react';
import { useToast } from '../context/ToastContext';
import { adminService } from '../services/adminService';

export default function NotificationPage() {
    const { t } = useTranslation();
    const [title, setTitle] = useState('');
    const [body, setBody] = useState('');
    const [segment, setSegment] = useState('all');
    const [isSending, setIsSending] = useState(false);
    const toast = useToast();

    const handleSend = async (e) => {
        e.preventDefault();
        try {
            setIsSending(true);
            await adminService.sendNotification({
                title,
                body,
                targetSegment: segment,
                type: 'broadcast'
            });
            toast.success('تم إرسال الإشعار بنجاح');
            setTitle('');
            setBody('');
        } catch (error) {
            toast.error('فشل إرسال الإشعار');
        } finally {
            setIsSending(false);
        }
    };

    return (
        <div className="space-y-6">
            <div>
                <h1 className="text-2xl font-bold text-gray-800">{t('push_notifications')}</h1>
                <p className="text-gray-500 mt-1">{t('push_notifications_subtitle')}</p>
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                {/* Compose Card */}
                <div className="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
                    <h2 className="text-lg font-bold text-gray-900 mb-6 flex items-center gap-2">
                        <Send size={20} className="text-indigo-600" />
                        {t('compose_notification')}
                    </h2>

                    <form onSubmit={handleSend} className="space-y-4">
                        <div>
                            <label className="block text-sm font-medium text-gray-700 mb-1">{t('target_audience')}</label>
                            <select
                                value={segment}
                                onChange={(e) => setSegment(e.target.value)}
                                className="w-full bg-gray-50 border border-gray-200 rounded-xl p-3 focus:ring-2 focus:ring-indigo-500 outline-none"
                            >
                                <option value="all">{t('all_users')}</option>
                                <option value="merchants">{t('merchants_only')}</option>
                                <option value="inactive">{t('inactive_users')}</option>
                            </select>
                        </div>

                        <div>
                            <label className="block text-sm font-medium text-gray-700 mb-1">{t('notification_title')}</label>
                            <input
                                type="text"
                                value={title}
                                onChange={(e) => setTitle(e.target.value)}
                                className="w-full bg-gray-50 border border-gray-200 rounded-xl p-3 focus:ring-2 focus:ring-indigo-500 outline-none"
                                placeholder={t('enter_title')}
                                required
                            />
                        </div>

                        <div>
                            <label className="block text-sm font-medium text-gray-700 mb-1">{t('notification_body')}</label>
                            <textarea
                                value={body}
                                onChange={(e) => setBody(e.target.value)}
                                rows={4}
                                className="w-full bg-gray-50 border border-gray-200 rounded-xl p-3 focus:ring-2 focus:ring-indigo-500 outline-none resize-none"
                                placeholder={t('enter_message')}
                                required
                            />
                        </div>

                        <div className="pt-2">
                            <button
                                type="submit"
                                disabled={isSending}
                                className="w-full bg-indigo-600 text-white py-3 rounded-xl hover:bg-indigo-700 transition-colors flex items-center justify-center gap-2 font-medium disabled:opacity-70"
                            >
                                {isSending ? (
                                    <div className="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                                ) : (
                                    <>
                                        <Send size={18} />
                                        {t('send_now')}
                                    </>
                                )}
                            </button>
                        </div>
                    </form>
                </div>

                {/* Preview & Stats */}
                <div className="space-y-6">
                    {/* Preview */}
                    <div className="bg-gray-900 rounded-[2.5rem] p-4 max-w-sm mx-auto shadow-2xl border-4 border-gray-800">
                        <div className="bg-gray-800 h-full rounded-[2rem] overflow-hidden relative">
                            {/* StatusBar */}
                            <div className="h-6 bg-black flex justify-between items-center px-4">
                                <span className="text-white text-xs">9:41</span>
                                <div className="flex gap-1">
                                    <div className="w-3 h-3 bg-white rounded-full opacity-20"></div>
                                    <div className="w-3 h-3 bg-white rounded-full opacity-20"></div>
                                </div>
                            </div>

                            {/* App Content */}
                            <div className="p-4 pt-10">
                                {/* Notification Pop */}
                                <div className="bg-white/95 backdrop-blur-sm p-3 rounded-2xl shadow-lg mb-4 animate-slide-in">
                                    <div className="flex gap-3">
                                        <div className="w-10 h-10 bg-indigo-600 rounded-xl flex items-center justify-center shrink-0">
                                            <Bell size={20} className="text-white" />
                                        </div>
                                        <div className="flex-1 min-w-0">
                                            <div className="flex justify-between items-start">
                                                <h4 className="font-semibold text-gray-900 text-sm truncate">{title || 'Taabor'}</h4>
                                                <span className="text-[10px] text-gray-500">now</span>
                                            </div>
                                            <p className="text-xs text-gray-600 leading-tight mt-0.5 break-words">
                                                {body || 'Your notification message will appear here...'}
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    {/* Stats */}
                    <div className="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
                        <h3 className="font-bold text-gray-900 mb-4">{t('campaign_stats')}</h3>
                        <div className="space-y-4">
                            <div className="flex items-center justify-between p-3 bg-indigo-50 rounded-xl">
                                <div className="flex items-center gap-3">
                                    <Users size={18} className="text-indigo-600" />
                                    <span className="text-sm font-medium text-gray-700">{t('total_reach')}</span>
                                </div>
                                <span className="font-bold text-indigo-700">8,432</span>
                            </div>
                            <div className="flex items-center justify-between p-3 bg-green-50 rounded-xl">
                                <div className="flex items-center gap-3">
                                    <Clock size={18} className="text-green-600" />
                                    <span className="text-sm font-medium text-gray-700">{t('last_sent')}</span>
                                </div>
                                <span className="font-bold text-green-700">2h ago</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}
