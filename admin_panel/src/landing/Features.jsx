import React from 'react';
import { useTranslation } from 'react-i18next';
import { Smartphone, Clock, Calendar, ShieldCheck, Zap, BarChart3 } from 'lucide-react';

export default function Features() {
    const { t } = useTranslation();

    const features = [
        {
            icon: <Clock size={24} />,
            title: "Smart Queuing",
            description: "Join queues remotely and track your turn in real-time. No more waiting in line physically.",
            color: "indigo"
        },
        {
            icon: <Calendar size={24} />,
            title: "Instant Booking",
            description: "Book appointments with your favorite businesses in seconds. Manage your schedule effortlessly.",
            color: "purple"
        },
        {
            icon: <Zap size={24} />,
            title: "Real-time Alerts",
            description: "Get notified when your turn is approaching. Never miss an appointment again.",
            color: "amber"
        },
        {
            icon: <ShieldCheck size={24} />,
            title: "Secure & Private",
            description: "Your data is encrypted and secure. We prioritize your privacy above all else.",
            color: "emerald"
        },
        {
            icon: <Smartphone size={24} />,
            title: "User Friendly",
            description: "Intuitive interface designed for everyone. Booking a slot is as easy as sending a text.",
            color: "pink"
        },
        {
            icon: <BarChart3 size={24} />,
            title: "Business Insights",
            description: "Merchants get detailed analytics on customer flow and peak times to optimize service.",
            color: "blue"
        }
    ];

    return (
        <section id="features" className="py-24 bg-gray-50">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="text-center max-w-3xl mx-auto mb-16">
                    <h2 className="text-base font-semibold text-indigo-600 uppercase tracking-wide mb-2">{t('features_eyebrow')}</h2>
                    <h3 className="text-3xl lg:text-4xl font-extrabold text-slate-900 mb-4">{t('features_title')}</h3>
                    <p className="text-lg text-slate-600">{t('features_subtitle')}</p>
                </div>

                <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
                    {features.map((feature, index) => (
                        <div key={index} className="bg-white p-8 rounded-3xl shadow-sm border border-gray-100 hover:shadow-lg transition-all hover:border-indigo-100 group">
                            <div className={`w-14 h-14 rounded-2xl bg-${feature.color}-100 flex items-center justify-center text-${feature.color}-600 mb-6 group-hover:scale-110 transition-transform`}>
                                {feature.icon}
                            </div>
                            <h4 className="text-xl font-bold text-slate-900 mb-3">{feature.title}</h4>
                            <p className="text-slate-600 leading-relaxed">{feature.description}</p>
                        </div>
                    ))}
                </div>
            </div>
        </section>
    );
}
