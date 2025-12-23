import React from 'react';
import { useTranslation } from 'react-i18next';
import { ArrowRight, Star, Clock, CheckCircle } from 'lucide-react';
import { Link } from 'react-scroll';

// Mockup image - normally we'd import the asset we generated
// import homeMockup from '../assets/app_mockup_home.png';

export default function Hero() {
    const { t, i18n } = useTranslation();
    const isRTL = i18n.dir() === 'rtl';

    return (
        <section id="hero" className="pt-32 pb-20 lg:pt-48 lg:pb-32 overflow-hidden bg-gradient-to-b from-indigo-50/50 to-white relative">
            {/* Background Blobs */}
            <div className={`absolute top-0 ${isRTL ? 'left-0' : 'right-0'} w-1/2 h-full bg-indigo-50/50 skew-x-12 -z-10`} />
            <div className="absolute top-20 left-20 w-72 h-72 bg-purple-200 rounded-full mix-blend-multiply filter blur-3xl opacity-30 animate-blob"></div>
            <div className="absolute top-20 right-20 w-72 h-72 bg-indigo-200 rounded-full mix-blend-multiply filter blur-3xl opacity-30 animate-blob animation-delay-2000"></div>

            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative">
                <div className="grid lg:grid-cols-2 gap-12 lg:gap-8 items-center">
                    {/* Text Content */}
                    <div className="text-center lg:text-start space-y-8 animate-fade-in-up">
                        <div className="inline-flex items-center gap-2 px-4 py-2 bg-white rounded-full border border-indigo-100 shadow-sm text-indigo-600 text-sm font-semibold mb-4 mx-auto lg:mx-0">
                            <span className="relative flex h-3 w-3">
                                <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-indigo-400 opacity-75"></span>
                                <span className="relative inline-flex rounded-full h-3 w-3 bg-indigo-500"></span>
                            </span>
                            {t('hero_badge')} #1 Queue App
                        </div>

                        <h1 className="text-4xl lg:text-6xl font-extrabold text-slate-900 tracking-tight leading-tight">
                            {t('hero_title_1')}{' '}
                            <span className="text-transparent bg-clip-text bg-gradient-to-r from-indigo-600 to-purple-600">
                                {t('hero_title_highlight')}
                            </span>
                            <br />
                            {t('hero_title_2')}
                        </h1>

                        <p className="text-lg text-slate-600 max-w-2xl mx-auto lg:mx-0 leading-relaxed">
                            {t('hero_description')}
                        </p>

                        <div className="flex flex-col sm:flex-row items-center gap-4 justify-center lg:justify-start">
                            <button className="bg-slate-900 text-white px-8 py-4 rounded-2xl font-bold flex items-center gap-3 hover:bg-slate-800 transition-all shadow-xl hover:shadow-2xl hover:-translate-y-1 transform w-full sm:w-auto justify-center">
                                <img src="https://upload.wikimedia.org/wikipedia/commons/3/3c/Download_on_the_App_Store_Badge.svg" alt="App Store" className="h-8" />
                            </button>
                            <button className="bg-slate-900 text-white px-8 py-4 rounded-2xl font-bold flex items-center gap-3 hover:bg-slate-800 transition-all shadow-xl hover:shadow-2xl hover:-translate-y-1 transform w-full sm:w-auto justify-center">
                                <img src="https://upload.wikimedia.org/wikipedia/commons/7/78/Google_Play_Store_badge_EN.svg" alt="Play Store" className="h-8" />
                            </button>
                        </div>

                        <div className="flex items-center gap-6 justify-center lg:justify-start pt-4">
                            <div className="flex -space-x-4 rtl:space-x-reverse">
                                <img src="https://i.pravatar.cc/100?img=1" alt="User" className="w-10 h-10 rounded-full border-2 border-white" />
                                <img src="https://i.pravatar.cc/100?img=2" alt="User" className="w-10 h-10 rounded-full border-2 border-white" />
                                <img src="https://i.pravatar.cc/100?img=3" alt="User" className="w-10 h-10 rounded-full border-2 border-white" />
                                <div className="w-10 h-10 rounded-full border-2 border-white bg-indigo-50 flex items-center justify-center text-xs font-bold text-indigo-600">+2k</div>
                            </div>
                            <div className="text-sm font-medium text-slate-600">
                                <div className="flex items-center gap-1 text-amber-500">
                                    <Star size={16} fill="currentColor" />
                                    <Star size={16} fill="currentColor" />
                                    <Star size={16} fill="currentColor" />
                                    <Star size={16} fill="currentColor" />
                                    <Star size={16} fill="currentColor" />
                                </div>
                                <span>{t('hero_rating_label')}</span>
                            </div>
                        </div>
                    </div>

                    {/* Image Mockup */}
                    <div className="relative animate-float lg:h-[600px] flex items-center justify-center">
                        {/* Circle Background */}
                        <div className="absolute w-[400px] h-[400px] bg-gradient-to-tr from-indigo-200 to-purple-200 rounded-full opacity-50 blur-2xl"></div>

                        {/* Phone Mockup (CSS only representation or img) */}
                        <div className="relative z-10 mx-auto w-72 h-[580px] bg-slate-900 rounded-[3rem] border-8 border-slate-900 shadow-2xl overflow-hidden">
                            <div className="absolute top-0 w-full h-8 bg-slate-900 z-20 rounded-t-[2.5rem] flex justify-center items-center">
                                <div className="w-20 h-4 bg-black rounded-full"></div>
                            </div>
                            {/* Screen Content Mock */}
                            <div className="w-full h-full bg-indigo-50 rounded-[2.5rem] overflow-hidden flex flex-col pt-10 px-4 pb-4">
                                <h3 className="text-xl font-bold text-slate-800 px-2 mt-4">Current Queue</h3>
                                <div className="mt-8 flex items-center justify-center">
                                    <div className="w-48 h-48 rounded-full border-[12px] border-indigo-200 border-t-indigo-600 flex flex-col items-center justify-center bg-white shadow-lg">
                                        <span className="text-4xl font-bold text-indigo-600">00:10</span>
                                        <span className="text-xs text-gray-400 font-medium">MINUTES</span>
                                    </div>
                                </div>
                                <div className="mt-8 space-y-3">
                                    <div className="bg-white p-4 rounded-2xl shadow-sm flex items-center gap-3">
                                        <Clock size={20} className="text-indigo-600" />
                                        <div className="flex-1">
                                            <div className="h-2 w-24 bg-gray-200 rounded mb-1"></div>
                                            <div className="h-2 w-16 bg-gray-100 rounded"></div>
                                        </div>
                                    </div>
                                    <div className="bg-white p-4 rounded-2xl shadow-sm flex items-center gap-3">
                                        <CheckCircle size={20} className="text-green-500" />
                                        <div className="flex-1">
                                            <div className="h-2 w-32 bg-gray-200 rounded mb-1"></div>
                                            <div className="h-2 w-20 bg-gray-100 rounded"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>


                        {/* Floating Cards */}
                        <div className="absolute top-1/2 -right-4 lg:-right-12 bg-white p-4 rounded-2xl shadow-xl animate-bounce-slow">
                            <div className="flex items-center gap-3">
                                <div className="w-10 h-10 bg-green-100 rounded-full flex items-center justify-center text-green-600">
                                    <CheckCircle size={20} />
                                </div>
                                <div>
                                    <p className="font-bold text-slate-800">Booking Confirmed</p>
                                    <p className="text-xs text-slate-500">Just now</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    );
}
