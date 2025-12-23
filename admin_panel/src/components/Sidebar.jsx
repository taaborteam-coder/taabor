import React from 'react';
import { NavLink } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import {
    LayoutDashboard,
    Store,
    Users,
    Settings,
    BarChart,
    Settings,
    BarChart,
    ListOrdered,
    Bell,
    MessageSquare
} from 'lucide-react';

const Sidebar = ({ isOpen }) => {
    const { t, i18n } = useTranslation();
    const isRTL = i18n.dir() === 'rtl';

    const menuItems = [
        { path: '/dashboard', icon: <LayoutDashboard size={20} />, label: t('dashboard') },
        { path: '/dashboard/businesses', icon: <Store size={20} />, label: t('businesses') },
        { path: '/dashboard/queues', icon: <ListOrdered size={20} />, label: t('queues') },
        { path: '/dashboard/users', icon: <Users size={20} />, label: t('users') },
        { path: '/dashboard/analytics', icon: <BarChart size={20} />, label: t('analytics') },
        { path: '/dashboard/notifications', icon: <Bell size={20} />, label: t('notifications') },
        { path: '/dashboard/reviews', icon: <MessageSquare size={20} />, label: t('reviews') },
        { path: '/dashboard/settings', icon: <Settings size={20} />, label: t('settings') },
    ];

    return (
        <aside className={`bg-slate-900 text-white transition-all duration-300 ${isOpen ? 'w-64' : 'w-20'} flex flex-col h-full shadow-xl z-20`}>
            {/* Logo Area */}
            <div className={`h-16 flex items-center ${isOpen ? 'justify-start px-6' : 'justify-center'} border-b border-slate-800`}>
                <div className="w-8 h-8 bg-indigo-600 rounded-lg flex items-center justify-center shrink-0">
                    <span className="font-bold text-lg text-white">T</span>
                </div>
                {isOpen && (
                    <span className={`font-bold text-xl ml-3 ${isRTL ? 'mr-3 ml-0' : 'ml-3'}`}>
                        {t('taabor_admin')}
                    </span>
                )}
            </div>

            {/* Navigation */}
            <nav className="flex-1 py-6 px-3 space-y-1 overflow-y-auto">
                {menuItems.map((item) => (
                    <NavLink
                        key={item.path}
                        to={item.path}
                        className={({ isActive }) => `
                            flex items-center p-3 rounded-lg transition-all duration-200 group
                            ${isActive
                                ? 'bg-indigo-600 text-white shadow-lg shadow-indigo-900/50'
                                : 'text-slate-400 hover:bg-slate-800 hover:text-white'
                            }
                            ${isOpen ? 'justify-start' : 'justify-center'}
                        `}
                    >
                        <span className={`${!isOpen ? '' : isRTL ? 'ml-3' : 'mr-3'}`}>
                            {item.icon}
                        </span>

                        {isOpen && (
                            <span className="font-medium text-sm whitespace-nowrap">
                                {item.label}
                            </span>
                        )}

                        {!isOpen && (
                            <div className={`
                                absolute ${isRTL ? 'right-full mr-2' : 'left-full ml-2'} 
                                px-2 py-1 bg-slate-800 text-white text-xs rounded opacity-0 
                                group-hover:opacity-100 pointer-events-none transition-opacity z-50 whitespace-nowrap
                            `}>
                                {item.label}
                            </div>
                        )}
                    </NavLink>
                ))}
            </nav>

            {/* User Profile Snippet (Bottom) */}
            <div className="p-4 border-t border-slate-800">
                <div className={`flex items-center ${isOpen ? 'justify-start gap-3' : 'justify-center'}`}>
                    <div className="w-8 h-8 rounded-full bg-gradient-to-tr from-indigo-500 to-purple-500 flex items-center justify-center text-xs font-bold ring-2 ring-slate-700">
                        A
                    </div>
                    {isOpen && (
                        <div className="overflow-hidden">
                            <p className="text-sm font-medium text-white truncate">Admin User</p>
                            <p className="text-xs text-slate-500 truncate">admin@taabor.com</p>
                        </div>
                    )}
                </div>
            </div>
        </aside>
    );
};

export default Sidebar;
