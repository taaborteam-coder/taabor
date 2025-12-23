import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ChevronDown, ChevronUp } from 'lucide-react';

export default function FAQ() {
    const { t } = useTranslation();
    const [openIndex, setOpenIndex] = useState(0);

    const faqs = [
        {
            question: "How does Taabor reduce waiting time?",
            answer: "Taabor allows you to join a queue remotely. You receive real-time updates and notifications, so you only arrive when it's your turn, effectively eliminating physical waiting time."
        },
        {
            question: "Is the app free to use?",
            answer: "Yes, Taabor is completely free for customers. You can book appointments and join queues at no cost."
        },
        {
            question: "How do I book an appointment?",
            answer: "Simply search for your favorite business, select a service, choose an available time slot, and confirm. It takes less than 30 seconds."
        },
        {
            question: "Can I cancel my booking?",
            answer: "Yes, you can cancel or reschedule your booking directly from the app up to 30 minutes before the scheduled time."
        },
        {
            question: "How do I list my business on Taabor?",
            answer: "Download the app and select 'Register as Merchant'. Fill in your business details, and our team will verify your account within 24 hours."
        }
    ];

    return (
        <section id="faq" className="py-24 bg-white">
            <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="text-center mb-16">
                    <h2 className="text-base font-semibold text-indigo-600 uppercase tracking-wide mb-2">{t('faq_eyebrow')} FAQ</h2>
                    <h3 className="text-3xl font-extrabold text-slate-900">{t('faq_title')} Frequently Asked Questions</h3>
                </div>

                <div className="space-y-4">
                    {faqs.map((faq, index) => (
                        <div key={index} className="border border-gray-200 rounded-2xl overflow-hidden">
                            <button
                                className="w-full px-6 py-4 text-left flex justify-between items-center bg-white hover:bg-gray-50 transition-colors"
                                onClick={() => setOpenIndex(index === openIndex ? -1 : index)}
                            >
                                <span className="font-semibold text-slate-900">{faq.question}</span>
                                {index === openIndex ? <ChevronUp className="text-indigo-600" /> : <ChevronDown className="text-gray-400" />}
                            </button>
                            {index === openIndex && (
                                <div className="px-6 pb-4 bg-gray-50/50">
                                    <p className="text-slate-600">{faq.answer}</p>
                                </div>
                            )}
                        </div>
                    ))}
                </div>
            </div>
        </section>
    );
}
