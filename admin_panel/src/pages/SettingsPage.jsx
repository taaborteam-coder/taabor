import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { User, Bell, Shield, Save, Globe, Mail } from 'lucide-react';

const SettingsPage = () => {
    const { t, i18n } = useTranslation();
    const isRTL = i18n.dir() === 'rtl';
    const [activeTab, setActiveTab] = useState('general');

    const tabs = [
        { id: 'general', label: t('general_tab'), icon: User },
        { id: 'notifications', label: t('notifications_tab'), icon: Bell },
        { id: 'security', label: t('security_tab'), icon: Shield },
    ];

    return (
        <div className="space-y-6">
            <div>
                <h1 className="text-2xl font-bold text-gray-800">{t('settings_title')}</h1>
                <p className="text-gray-500 mt-1">{t('settings_subtitle')}</p>
            </div>

            <div className="flex flex-col md:flex-row gap-6">
                {/* Sidebar Navigation for Settings */}
                <div className="w-full md:w-64 shrink-0">
                    <div className="bg-white rounded-2xl shadow-sm border border-gray-100 p-2 space-y-1">
                        {tabs.map((tab) => {
                            const Icon = tab.icon;
                            return (
                                <button
                                    key={tab.id}
                                    onClick={() => setActiveTab(tab.id)}
                                    className={`w-full flex items-center gap-3 px-4 py-3 rounded-xl text-sm font-medium transition-colors ${activeTab === tab.id
                                        ? 'bg-indigo-50 text-indigo-700'
                                        : 'text-gray-600 hover:bg-gray-50'
                                        }`}
                                >
                                    <Icon size={18} />
                                    <span>{tab.label}</span>
                                </button>
                            );
                        })}
                    </div>
                </div>

                {/* Content Area */}
                <div className="flex-1 bg-white rounded-2xl shadow-sm border border-gray-100 p-6 md:p-8">

                    {/* General Tab */}
                    {activeTab === 'general' && (
                        <div className="space-y-6 animate-in fade-in slide-in-from-bottom-2 duration-300">
                            <h3 className="text-lg font-bold text-gray-800 border-b pb-4 mb-6">{t('general_tab')}</h3>

                            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div className="space-y-2">
                                    <label className="text-sm font-medium text-gray-700">{t('app_name')}</label>
                                    <input
                                        type="text"
                                        defaultValue="Taabor Admin"
                                        className="w-full px-4 py-2 border border-gray-200 rounded-lg focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 outline-none"
                                    />
                                </div>
                                <div className="space-y-2">
                                    <label className="text-sm font-medium text-gray-700">{t('language_default')}</label>
                                    <div className="relative">
                                        <Globe size={18} className={`absolute ${isRTL ? 'right-3' : 'left-3'} top-1/2 -translate-y-1/2 text-gray-400`} />
                                        <select
                                            value={i18n.language}
                                            onChange={(e) => i18n.changeLanguage(e.target.value)}
                                            className={`w-full ${isRTL ? 'pr-10 pl-4' : 'pl-10 pr-4'} py-2 border border-gray-200 rounded-lg bg-white outline-none focus:border-indigo-500`}
                                        >
                                            <option value="ar">العربية (Arabic)</option>
                                            <option value="en">English</option>
                                            <option value="ku">کوردی (Kurdish)</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div className="pt-4 flex justify-end">
                                <button className="bg-indigo-600 text-white px-6 py-2 rounded-lg hover:bg-indigo-700 flex items-center gap-2">
                                    <Save size={18} />
                                    <span>{t('save_changes')}</span>
                                </button>
                            </div>
                        </div>
                    )}

                    {/* Notifications Tab */}
                    {activeTab === 'notifications' && (
                        <div className="space-y-6 animate-in fade-in slide-in-from-bottom-2 duration-300">
                            <h3 className="text-lg font-bold text-gray-800 border-b pb-4 mb-6">{t('notifications_tab')}</h3>

                            <div className="space-y-4">
                                <div className="flex items-center justify-between p-4 bg-gray-50 rounded-xl">
                                    <div className="flex items-center gap-3">
                                        <div className="p-2 bg-indigo-100 text-indigo-600 rounded-lg">
                                            <Mail size={20} />
                                        </div>
                                        <div>
                                            <p className="font-medium text-gray-800">{t('email_notifications')}</p>
                                            <p className="text-xs text-gray-500">Receive weekly summaries and alerts.</p>
                                        </div>
                                    </div>
                                    <label className="relative inline-flex items-center cursor-pointer">
                                        <input type="checkbox" defaultChecked className="sr-only peer" />
                                        <div className="w-11 h-6 bg-gray-200 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-indigo-600"></div>
                                    </label>
                                </div>

                                <div className="flex items-center justify-between p-4 bg-gray-50 rounded-xl">
                                    <div className="flex items-center gap-3">
                                        <div className="p-2 bg-pink-100 text-pink-600 rounded-lg">
                                            <Bell size={20} />
                                        </div>
                                        <div>
                                            <p className="font-medium text-gray-800">{t('push_notifications')}</p>
                                            <p className="text-xs text-gray-500">Get real-time updates on your phone.</p>
                                        </div>
                                    </div>
                                    <label className="relative inline-flex items-center cursor-pointer">
                                        <input type="checkbox" className="sr-only peer" />
                                        <div className="w-11 h-6 bg-gray-200 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-indigo-600"></div>
                                    </label>
                                </div>
                            </div>
                        </div>
                    )}

                    {/* Security Tab */}
                    {activeTab === 'security' && (
                        <div className="space-y-6 animate-in fade-in slide-in-from-bottom-2 duration-300">
                            <h3 className="text-lg font-bold text-gray-800 border-b pb-4 mb-6">{t('security_tab')}</h3>

                            <div className="max-w-md space-y-4">
                                <div className="space-y-2">
                                    <label className="text-sm font-medium text-gray-700">Current Password</label>
                                    <input type="password" className="w-full px-4 py-2 border border-gray-200 rounded-lg outline-none focus:border-indigo-500" />
                                </div>
                                <div className="space-y-2">
                                    <label className="text-sm font-medium text-gray-700">New Password</label>
                                    <input type="password" className="w-full px-4 py-2 border border-gray-200 rounded-lg outline-none focus:border-indigo-500" />
                                </div>
                                <div className="pt-2">
                                    <button className="bg-gray-800 text-white px-6 py-2 rounded-lg hover:bg-gray-900 w-full md:w-auto">
                                        {t('change_password')}
                                    </button>
                                </div>
                            </div>
                        </div>
                    )}

                </div>
            </div>
        </div>
    );
};

export default SettingsPage;
