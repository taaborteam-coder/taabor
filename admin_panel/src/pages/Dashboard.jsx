import React from 'react';
import { useTranslation } from 'react-i18next';
import {
    BarChart as ReBarChart,
    Bar,
    XAxis,
    YAxis,
    CartesianGrid,
    Tooltip,
    ResponsiveContainer
} from 'recharts';
import { Store, TrendingUp, Users, Ticket, ArrowUpRight, ArrowDownRight, MoreHorizontal } from 'lucide-react';
import ExportButton from '../components/ExportButton'; // Added import for ExportButton

// Mock Data
const chartData = [
    { name: 'Sat', tickets: 400 },
    { name: 'Sun', tickets: 300 },
    { name: 'Mon', tickets: 200 },
    { name: 'Tue', tickets: 278 },
    { name: 'Wed', tickets: 189 },
    { name: 'Thu', tickets: 239 },
    { name: 'Fri', tickets: 349 },
];

const mockBusinesses = [
    { id: 1, name: 'Salon Elegance', type: 'Salon', status: 'Active', location: 'Baghdad' },
    { id: 2, name: 'Dr. Sara Clinic', type: 'Clinic', status: 'Pending', location: 'Erbil' },
    { id: 3, name: 'Burger Joint', type: 'Restaurant', status: 'Active', location: 'Baghdad' },
    { id: 4, name: 'City Lab', type: 'Laboratory', status: 'Active', location: 'Basra' },
];

const Dashboard = () => {
    const { t, i18n } = useTranslation();
    const isRTL = i18n.dir() === 'rtl';

    const stats = [
        { title: t('total_businesses'), value: '124', change: '+12%', color: 'blue', icon: Store },
        { title: t('total_users'), value: '8,432', change: '+5%', color: 'emerald', icon: Users },
        { title: t('active_tickets'), value: '432', change: '-2%', color: 'violet', icon: Ticket },
        { title: t('revenue'), value: '$12,450', change: '+18%', color: 'amber', icon: TrendingUp },
    ];

    return (
        <div className="p-6 space-y-6">
            <div className="flex justify-between items-center">
                <h1 className="text-2xl font-bold text-gray-800">Dashboard Overview</h1>
                <div className="flex gap-2">
                    <span className="text-sm text-gray-500 self-center">Last updated: {new Date().toLocaleTimeString()}</span>
                    <ExportButton data={recentBookings} filename="dashboard_report" />
                    <select className="bg-white border border-gray-200 text-gray-700 text-sm rounded-lg p-2.5 focus:ring-indigo-500 focus:border-indigo-500 shadow-sm">
                        <option>Last 7 Days</option>
                        <option>Last 30 Days</option>
                        <option>This Month</option>
                    </select>
                </div>
            </div>

            {/* Stats Grid */}
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                {stats.map((stat, index) => {
                    const Icon = stat.icon;
                    const isPositive = stat.change.startsWith('+');
                    return (
                        <div key={index} className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 hover:shadow-md transition-shadow">
                            <div className="flex justify-between items-start mb-4">
                                <div className={`p-3 rounded-xl bg-${stat.color}-100/50 text-${stat.color}-600`}>
                                    <Icon size={24} />
                                </div>
                                <span className={`flex items-center text-xs font-semibold px-2 py-1 rounded-full ${isPositive ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}`}>
                                    {isPositive ? <ArrowUpRight size={14} className="mr-1" /> : <ArrowDownRight size={14} className="mr-1" />}
                                    {stat.change}
                                </span>
                            </div>
                            <h3 className="text-3xl font-bold text-gray-800 mt-1">{stat.value}</h3>
                            <p className="text-gray-500 text-sm mt-1">{stat.title}</p>
                        </div>
                    );
                })}
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
                {/* Chart Section */}
                <div className="lg:col-span-2 bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
                    <div className="flex items-center justify-between mb-6">
                        <h2 className="text-lg font-bold text-gray-800">{t('ticket_volume')}</h2>
                        <button className="p-2 hover:bg-gray-100 rounded-lg text-gray-400">
                            <MoreHorizontal size={20} />
                        </button>
                    </div>
                    <div className="h-80 w-full">
                        <ResponsiveContainer width="100%" height="100%">
                            <ReBarChart data={chartData} margin={{ top: 10, right: 10, left: -20, bottom: 0 }}>
                                <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#E5E7EB" />
                                <XAxis
                                    dataKey="name"
                                    axisLine={false}
                                    tickLine={false}
                                    tick={{ fill: '#6B7280', fontSize: 12 }}
                                    dy={10}
                                />
                                <YAxis
                                    axisLine={false}
                                    tickLine={false}
                                    tick={{ fill: '#6B7280', fontSize: 12 }}
                                />
                                <Tooltip
                                    cursor={{ fill: 'transparent' }}
                                    contentStyle={{ borderRadius: '8px', border: 'none', boxShadow: '0 4px 6px -1px rgb(0 0 0 / 0.1)' }}
                                />
                                <Bar
                                    dataKey="tickets"
                                    fill="#6366f1"
                                    radius={[6, 6, 0, 0]}
                                    barSize={40}
                                />
                            </ReBarChart>
                        </ResponsiveContainer>
                    </div>
                </div>

                {/* Recent Businesses Section */}
                <div className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex flex-col">
                    <div className="flex items-center justify-between mb-6">
                        <h2 className="text-lg font-bold text-gray-800">{t('recent_businesses')}</h2>
                        <button className="text-sm text-indigo-600 font-medium hover:text-indigo-700">{t('view_all')}</button>
                    </div>
                    <div className="space-y-4 flex-1 overflow-y-auto pr-2 custom-scrollbar">
                        {mockBusinesses.map((biz) => (
                            <div key={biz.id} className="flex items-center justify-between p-3 rounded-xl hover:bg-gray-50 border border-transparent hover:border-gray-100 transition-all group">
                                <div className="flex items-center gap-3">
                                    <div className="w-10 h-10 bg-indigo-50 rounded-full flex items-center justify-center text-indigo-600 group-hover:bg-indigo-600 group-hover:text-white transition-colors">
                                        <Store size={18} />
                                    </div>
                                    <div className="flex-1 min-w-0">
                                        <p className="font-semibold text-gray-800 truncate">{biz.name}</p>
                                        <p className="text-xs text-gray-500 truncate">{biz.location} • {t(biz.type.toLowerCase())}</p>
                                    </div>
                                </div>
                                <span className={`text-xs px-2.5 py-1 rounded-full font-medium ${biz.status === 'Active'
                                    ? 'bg-green-100 text-green-700'
                                    : 'bg-yellow-100 text-yellow-700'
                                    }`}>
                                    {t(`status_${biz.status.toLowerCase()}`)}
                                </span>
                            </div>
                        ))}
                    </div>
                </div>
            </div>
        </div>
    );
};

export default Dashboard;
