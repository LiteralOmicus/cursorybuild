import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:convert';
import 'dart:io'; 
import 'package:path_provider/path_provider.dart'; 
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_cache/just_audio_cache.dart';
import 'xsxspile.dart' as forEducation;
import 'extralesson.dart' as extra;
import 'package:kangarule/firebase_options.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey = GlobalKey<ScaffoldMessengerState>();
const termsOfUse = """
TERMS OF USE
Last updated September 21, 2026


AGREEMENT TO OUR LEGAL TERMS
We are Kangarule ("Company," "we," "us," "our").

We operate the mobile application Kangarule (the "App"), as well as any other related products and services that refer or link to these legal terms (the "Legal Terms") (collectively, the "Services").

This is a language learning app that provides support for open licenses or permissive open-access licenses language learning textbooks to be used in a unique private learning format focusing on grammar and vocabulary for their own usage.

You can contact us by email at westleydunn30@gmail.com or by mail to __________, __________, __________.

These Legal Terms constitute a legally binding agreement made between you, whether personally or on behalf of an entity ("you"), and Kangarule, concerning your access to and use of the Services. You agree that by accessing the Services, you have read, understood, and agreed to be bound by all of these Legal Terms. IF YOU DO NOT AGREE WITH ALL OF THESE LEGAL TERMS, THEN YOU ARE EXPRESSLY PROHIBITED FROM USING THE SERVICES AND YOU MUST DISCONTINUE USE IMMEDIATELY.

Supplemental terms and conditions or documents that may be posted on the Services from time to time are hereby expressly incorporated herein by reference. We reserve the right, in our sole discretion, to make changes or modifications to these Legal Terms from time to time. We will alert you about any changes by updating the "Last updated" date of these Legal Terms, and you waive any right to receive specific notice of each such change. It is your responsibility to periodically review these Legal Terms to stay informed of updates. You will be subject to, and will be deemed to have been made aware of and to have accepted, the changes in any revised Legal Terms by your continued use of the Services after the date such revised Legal Terms are posted.

All users who are minors in the jurisdiction in which they reside (generally under the age of 18) must have the permission of, and be directly supervised by, their parent or guardian to use the Services. If you are a minor, you must have your parent or guardian read and agree to these Legal Terms prior to you using the Services.

We recommend that you print a copy of these Legal Terms for your records.

TABLE OF CONTENTS
1. OUR SERVICES
2. INTELLECTUAL PROPERTY RIGHTS
3. USER REPRESENTATIONS
4. USER REGISTRATION
5. PROHIBITED ACTIVITIES
6. USER GENERATED CONTRIBUTIONS
7. CONTRIBUTION LICENSE
8. MOBILE APPLICATION LICENSE
9. THIRD-PARTY WEBSITES AND CONTENT
10. ADVERTISERS
11. SERVICES MANAGEMENT
12. PRIVACY POLICY
13. COPYRIGHT INFRINGEMENTS
14. TERM AND TERMINATION
15. MODIFICATIONS AND INTERRUPTIONS
16. GOVERNING LAW
17. DISPUTE RESOLUTION
18. CORRECTIONS
19. DISCLAIMER
20. LIMITATIONS OF LIABILITY
21. INDEMNIFICATION
22. USER DATA
23. ELECTRONIC COMMUNICATIONS, TRANSACTIONS, AND SIGNATURES
24. CALIFORNIA USERS AND RESIDENTS
25. MISCELLANEOUS
26. AI AND AUTOMATED PROCESSING
27. DERIVED DATA AND RESEARCH RIGHTS
28. TRANSLATION AND ACCURACY DISCLAIMER
29. DATA RETENTION AND ANONYMIZATION
30. CONTACT US

1. OUR SERVICES
The information provided when using the Services is not intended for distribution to or use by any person or entity in any jurisdiction or country where such distribution or use would be contrary to law or regulation or which would subject us to any registration requirement within such jurisdiction or country. Accordingly, those persons who choose to access the Services from other locations do so on their own initiative and are solely responsible for compliance with local laws, if and to the extent local laws are applicable.

The Services are not tailored to comply with industry-specific regulations (Health Insurance Portability and Accountability Act (HIPAA), Federal Information Security Management Act (FISMA), etc.), so if your interactions would be subjected to such laws, you may not use the Services. You may not use the Services in a way that would violate the Gramm-Leach-Bliley Act (GLBA).

2. INTELLECTUAL PROPERTY RIGHTS
Our intellectual property
We are the owner or the licensee of all intellectual property rights in our Services, including all source code, databases, functionality, software, website designs, audio, video, text, photographs, and graphics in the Services (collectively, the "Content"), as well as the trademarks, service marks, and logos contained therein (the "Marks").

Our Content and Marks are protected by copyright and trademark laws (and various other intellectual property rights and unfair competition laws) and treaties in the United States and around the world.

The Content and Marks are provided in or through the Services "AS IS" for your personal, non-commercial use or internal business purpose only.
Your use of our Services
Subject to your compliance with these Legal Terms, including the "PROHIBITED ACTIVITIES" section below, we grant you a non-exclusive, non-transferable, revocable license to:
access the Services; and
download or print a copy of any portion of the Content to which you have properly gained access,
solely for your personal, non-commercial use or internal business purpose.

Except as set out in this section or elsewhere in our Legal Terms, no part of the Services and no Content or Marks may be copied, reproduced, aggregated, republished, uploaded, posted, publicly displayed, encoded, translated, transmitted, distributed, sold, licensed, or otherwise exploited for any commercial purpose whatsoever, without our express prior written permission.

If you wish to make any use of the Services, Content, or Marks other than as set out in this section or elsewhere in our Legal Terms, please address your request to: westleydunn30@gmail.com. If we ever grant you the permission to post, reproduce, or publicly display any part of our Services or Content, you must identify us as the owners or licensors of the Services, Content, or Marks and ensure that any copyright or proprietary notice appears or is visible on posting, reproducing, or displaying our Content.

We reserve all rights not expressly granted to you in and to the Services, Content, and Marks.

Any breach of these Intellectual Property Rights will constitute a material breach of our Legal Terms and your right to use our Services will terminate immediately.
Your submissions and contributions
Please review this section and the "PROHIBITED ACTIVITIES" section carefully prior to using our Services to understand the (a) rights you give us and (b) obligations you have when you post or upload any content through the Services.

Submissions: By directly sending us any question, comment, suggestion, idea, feedback, or other information about the Services ("Submissions"), you agree to assign to us all intellectual property rights in such Submission. You agree that we shall own this Submission and be entitled to its unrestricted use and dissemination for any lawful purpose, commercial or otherwise, without acknowledgment or compensation to you.

Contributions: The Services may invite you to chat, contribute to, or participate in blogs, message boards, online forums, and other functionality during which you may create, submit, post, display, transmit, publish, distribute, or broadcast content and materials to us or through the Services, including but not limited to text, writings, video, audio, photographs, music, graphics, comments, reviews, rating suggestions, personal information, or other material ("Contributions"). Any Submission that is publicly posted shall also be treated as a Contribution.

You understand that Contributions may be viewable by other users of the Services and possibly through third-party websites.

When you post Contributions, you grant us a license (including use of your name, trademarks, and logos): By posting any Contributions, you grant us an unrestricted, unlimited, irrevocable, perpetual, non-exclusive, transferable, royalty-free, fully-paid, worldwide right, and license to: use, copy, reproduce, distribute, sell, resell, publish, broadcast, retitle, store, publicly perform, publicly display, reformat, translate, excerpt (in whole or in part), and exploit your Contributions (including, without limitation, your image, name, and voice) for any purpose, commercial, advertising, or otherwise, to prepare derivative works of, or incorporate into other works, your Contributions, and to sublicense the licenses granted in this section. Our use and distribution may occur in any media formats and through any media channels.

This license includes our use of your name, company name, and franchise name, as applicable, and any of the trademarks, service marks, trade names, logos, and personal and commercial images you provide.

You are responsible for what you post or upload: By sending us Submissions and/or posting Contributions through any part of the Services or making Contributions accessible through the Services by linking your account through the Services to any of your social networking accounts, you:
confirm that you have read and agree with our "PROHIBITED ACTIVITIES" and will not post, send, publish, upload, or transmit through the Services any Submission nor post any Contribution that is illegal, harassing, hateful, harmful, defamatory, obscene, bullying, abusive, discriminatory, threatening to any person or group, sexually explicit, false, inaccurate, deceitful, or misleading;
to the extent permissible by applicable law, waive any and all moral rights to any such Submission and/or Contribution;
warrant that any such Submission and/or Contributions are original to you or that you have the necessary rights and licenses to submit such Submissions and/or Contributions and that you have full authority to grant us the above-mentioned rights in relation to your Submissions and/or Contributions; and
warrant and represent that your Submissions and/or Contributions do not constitute confidential information.
You are solely responsible for your Submissions and/or Contributions and you expressly agree to reimburse us for any and all losses that we may suffer because of your breach of (a) this section, (b) any third party’s intellectual property rights, or (c) applicable law.

We may remove or edit your Content: Although we have no obligation to monitor any Contributions, we shall have the right to remove or edit any Contributions at any time without notice if in our reasonable opinion we consider such Contributions harmful or in breach of these Legal Terms. If we remove or edit any such Contributions, we may also suspend or disable your account and report you to the authorities.
Copyright infringement
We respect the intellectual property rights of others. If you believe that any material available on or through the Services infringes upon any copyright you own or control, please immediately refer to the "COPYRIGHT INFRINGEMENTS" section below.

3. USER REPRESENTATIONS
By using the Services, you represent and warrant that: (1) all registration information you submit will be true, accurate, current, and complete; (2) you will maintain the accuracy of such information and promptly update such registration information as necessary; (3) you have the legal capacity and you agree to comply with these Legal Terms; (4) you are not a minor in the jurisdiction in which you reside, or if a minor, you have received parental permission to use the Services; (5) you will not access the Services through automated or non-human means, whether through a bot, script or otherwise; (6) you will not use the Services for any illegal or unauthorized purpose; and (7) your use of the Services will not violate any applicable law or regulation.

If you provide any information that is untrue, inaccurate, not current, or incomplete, we have the right to suspend or terminate your account and refuse any and all current or future use of the Services (or any portion thereof).

4. USER REGISTRATION
You may be required to register to use the Services. You agree to keep your password confidential and will be responsible for all use of your account and password. We reserve the right to remove, reclaim, or change a username you select if we determine, in our sole discretion, that such username is inappropriate, obscene, or otherwise objectionable.

5. PROHIBITED ACTIVITIES
You may not access or use the Services for any purpose other than that for which we make the Services available. The Services may not be used in connection with any commercial endeavors except those that are specifically endorsed or approved by us.

As a user of the Services, you agree not to:
Systematically retrieve data or other content from the Services to create or compile, directly or indirectly, a collection, compilation, database, or directory without written permission from us.
Trick, defraud, or mislead us and other users, especially in any attempt to learn sensitive account information such as user passwords.
Circumvent, disable, or otherwise interfere with security-related features of the Services, including features that prevent or restrict the use or copying of any Content or enforce limitations on the use of the Services and/or the Content contained therein.
Disparage, tarnish, or otherwise harm, in our opinion, us and/or the Services.
Use any information obtained from the Services in order to harass, abuse, or harm another person.
Make improper use of our support services or submit false reports of abuse or misconduct.
Use the Services in a manner inconsistent with any applicable laws or regulations.
Engage in unauthorized framing of or linking to the Services.
Upload or transmit (or attempt to upload or to transmit) viruses, Trojan horses, or other material, including excessive use of capital letters and spamming (continuous posting of repetitive text), that interferes with any party’s uninterrupted use and enjoyment of the Services or modifies, impairs, disrupts, alters, or interferes with the use, features, functions, operation, or maintenance of the Services.
Engage in any automated use of the system, such as using scripts to send comments or messages, or using any data mining, robots, or similar data gathering and extraction tools.
Delete the copyright or other proprietary rights notice from any Content.
Attempt to impersonate another user or person or use the username of another user.
Upload or transmit (or attempt to upload or to transmit) any material that acts as a passive or active information collection or transmission mechanism, including without limitation, clear graphics interchange formats ("gifs"), 1×1 pixels, web bugs, cookies, or other similar devices (sometimes referred to as "spyware" or "passive collection mechanisms" or "pcms").
Interfere with, disrupt, or create an undue burden on the Services or the networks or services connected to the Services.
Harass, annoy, intimidate, or threaten any of our employees or agents engaged in providing any portion of the Services to you.
Attempt to bypass any measures of the Services designed to prevent or restrict access to the Services, or any portion of the Services.
Copy or adapt the Services' software, including but not limited to Flash, PHP, HTML, JavaScript, or other code.
Except as permitted by applicable law, decipher, decompile, disassemble, or reverse engineer any of the software comprising or in any way making up a part of the Services.
Except as may be the result of standard search engine or Internet browser usage, use, launch, develop, or distribute any automated system, including without limitation, any spider, robot, cheat utility, scraper, or offline reader that accesses the Services, or use or launch any unauthorized script or other software.
Use a buying agent or purchasing agent to make purchases on the Services.
Make any unauthorized use of the Services, including collecting usernames and/or email addresses of users by electronic or other means for the purpose of sending unsolicited email, or creating user accounts by automated means or under false pretenses.
Use the Services as part of any effort to compete with us or otherwise use the Services and/or the Content for any revenue-generating endeavor or commercial enterprise.

6. USER GENERATED CONTRIBUTIONS
The Services may invite you to chat, contribute to, or participate in blogs, message boards, online forums, and other functionality, and may provide you with the opportunity to create, submit, post, display, transmit, perform, publish, distribute, or broadcast content and materials to us or on the Services, including but not limited to text, writings, video, audio, photographs, graphics, comments, suggestions, or personal information or other material (collectively, "Contributions"). Contributions may be viewable by other users of the Services and through third-party websites. As such, any Contributions you transmit may be treated as non-confidential and non-proprietary. When you create or make available any Contributions, you thereby represent and warrant that:
The creation, distribution, transmission, public display, or performance, and the accessing, downloading, or copying of your Contributions do not and will not infringe the proprietary rights, including but not limited to the copyright, patent, trademark, trade secret, or moral rights of any third party.
You are the creator and owner of or have the necessary licenses, rights, consents, releases, and permissions to use and to authorize us, the Services, and other users of the Services to use your Contributions in any manner contemplated by the Services and these Legal Terms.
You have the written consent, release, and/or permission of each and every identifiable individual person in your Contributions to use the name or likeness of each and every such identifiable individual person to enable inclusion and use of your Contributions in any manner contemplated by the Services and these Legal Terms.
Your Contributions are not false, inaccurate, or misleading.
Your Contributions are not unsolicited or unauthorized advertising, promotional materials, pyramid schemes, chain letters, spam, mass mailings, or other forms of solicitation.
Your Contributions are not obscene, lewd, lascivious, filthy, violent, harassing, libelous, slanderous, or otherwise objectionable (as determined by us).
Your Contributions do not ridicule, mock, disparage, intimidate, or abuse anyone.
Your Contributions are not used to harass or threaten (in the legal sense of those terms) any other person and to promote violence against a specific person or class of people.
Your Contributions do not violate any applicable law, regulation, or rule.
Your Contributions do not violate the privacy or publicity rights of any third party.
Your Contributions do not violate any applicable law concerning child pornography, or otherwise intended to protect the health or well-being of minors.
Your Contributions do not include any offensive comments that are connected to race, national origin, gender, sexual preference, or physical handicap.
Your Contributions do not otherwise violate, or link to material that violates, any provision of these Legal Terms, or any applicable law or regulation.
Any use of the Services in violation of the foregoing violates these Legal Terms and may result in, among other things, termination or suspension of your rights to use the Services.

7. CONTRIBUTION LICENSE
By posting your Contributions to any part of the Services, you automatically grant, and you represent and warrant that you have the right to grant, to us an unrestricted, unlimited, irrevocable, perpetual, non-exclusive, transferable, royalty-free, fully-paid, worldwide right, and license to host, use, copy, reproduce, disclose, sell, resell, publish, broadcast, retitle, archive, store, cache, publicly perform, publicly display, reformat, translate, transmit, excerpt (in whole or in part), and distribute such Contributions (including, without limitation, your image and voice) for any purpose, commercial, advertising, or otherwise, and to prepare derivative works of, or incorporate into other works, such Contributions, and grant and authorize sublicenses of the foregoing. The use and distribution may occur in any media formats and through any media channels.

This license will apply to any form, media, or technology now known or hereafter developed, and includes our use of your name, company name, and franchise name, as applicable, and any of the trademarks, service marks, trade names, logos, and personal and commercial images you provide. You waive all moral rights in your Contributions, and you warrant that moral rights have not otherwise been asserted in your Contributions.

We do not assert any ownership over your Contributions. You retain full ownership of all of your Contributions and any intellectual property rights or other proprietary rights associated with your Contributions. We are not liable for any statements or representations in your Contributions provided by you in any area on the Services. You are solely responsible for your Contributions to the Services and you expressly agree to exonerate us from any and all responsibility and to refrain from any legal action against us regarding your Contributions.

We have the right, in our sole and absolute discretion, (1) to edit, redact, or otherwise change any Contributions; (2) to re-categorize any Contributions to place them in more appropriate locations on the Services; and (3) to pre-screen or delete any Contributions at any time and for any reason, without notice. We have no obligation to monitor your Contributions.

8. MOBILE APPLICATION LICENSE
Use License
If you access the Services via the App, then we grant you a revocable, non-exclusive, non-transferable, limited right to install and use the App on wireless electronic devices owned or controlled by you, and to access and use the App on such devices strictly in accordance with the terms and conditions of this mobile application license contained in these Legal Terms. You shall not: (1) except as permitted by applicable law, decompile, reverse engineer, disassemble, attempt to derive the source code of, or decrypt the App; (2) make any modification, adaptation, improvement, enhancement, translation, or derivative work from the App; (3) violate any applicable laws, rules, or regulations in connection with your access or use of the App; (4) remove, alter, or obscure any proprietary notice (including any notice of copyright or trademark) posted by us or the licensors of the App; (5) use the App for any revenue-generating endeavor, commercial enterprise, or other purpose for which it is not designed or intended; (6) make the App available over a network or other environment permitting access or use by multiple devices or users at the same time; (7) use the App for creating a product, service, or software that is, directly or indirectly, competitive with or in any way a substitute for the App; (8) use the App to send automated queries to any website or to send any unsolicited commercial email; or (9) use any proprietary information or any of our interfaces or our other intellectual property in the design, development, manufacture, licensing, or distribution of any applications, accessories, or devices for use with the App.
Apple and Android Devices
The following terms apply when you use the App obtained from either the Apple Store or Google Play (each an "App Distributor") to access the Services: (1) the license granted to you for our App is limited to a non-transferable license to use the application on a device that utilizes the Apple iOS or Android operating systems, as applicable, and in accordance with the usage rules set forth in the applicable App Distributor’s terms of service; (2) we are responsible for providing any maintenance and support services with respect to the App as specified in the terms and conditions of this mobile application license contained in these Legal Terms or as otherwise required under applicable law, and you acknowledge that each App Distributor has no obligation whatsoever to furnish any maintenance and support services with respect to the App; (3) in the event of any failure of the App to conform to any applicable warranty, you may notify the applicable App Distributor, and the App Distributor, in accordance with its terms and policies, may refund the purchase price, if any, paid for the App, and to the maximum extent permitted by applicable law, the App Distributor will have no other warranty obligation whatsoever with respect to the App; (4) you represent and warrant that (i) you are not located in a country that is subject to a US government embargo, or that has been designated by the US government as a "terrorist supporting" country and (ii) you are not listed on any US government list of prohibited or restricted parties; (5) you must comply with applicable third-party terms of agreement when using the App, e.g., if you have a VoIP application, then you must not be in violation of their wireless data service agreement when using the App; and (6) you acknowledge and agree that the App Distributors are third-party beneficiaries of the terms and conditions in this mobile application license contained in these Legal Terms, and that each App Distributor will have the right (and will be deemed to have accepted the right) to enforce the terms and conditions in this mobile application license contained in these Legal Terms against you as a third-party beneficiary thereof.

9. THIRD-PARTY WEBSITES AND CONTENT
The Services may contain (or you may be sent via the App) links to other websites ("Third-Party Websites") as well as articles, photographs, text, graphics, pictures, designs, music, sound, video, information, applications, software, and other content or items belonging to or originating from third parties ("Third-Party Content"). Such Third-Party Websites and Third-Party Content are not investigated, monitored, or checked for accuracy, appropriateness, or completeness by us, and we are not responsible for any Third-Party Websites accessed through the Services or any Third-Party Content posted on, available through, or installed from the Services, including the content, accuracy, offensiveness, opinions, reliability, privacy practices, or other policies of or contained in the Third-Party Websites or the Third-Party Content. Inclusion of, linking to, or permitting the use or installation of any Third-Party Websites or any Third-Party Content does not imply approval or endorsement thereof by us. If you decide to leave the Services and access the Third-Party Websites or to use or install any Third-Party Content, you do so at your own risk, and you should be aware these Legal Terms no longer govern. You should review the applicable terms and policies, including privacy and data gathering practices, of any website to which you navigate from the Services or relating to any applications you use or install from the Services. Any purchases you make through Third-Party Websites will be through other websites and from other companies, and we take no responsibility whatsoever in relation to such purchases which are exclusively between you and the applicable third party. You agree and acknowledge that we do not endorse the products or services offered on Third-Party Websites and you shall hold us blameless from any harm caused by your purchase of such products or services. Additionally, you shall hold us blameless from any losses sustained by you or harm caused to you relating to or resulting in any way from any Third-Party Content or any contact with Third-Party Websites.

10. ADVERTISERS
We allow advertisers to display their advertisements and other information in certain areas of the Services, such as sidebar advertisements or banner advertisements. We simply provide the space to place such advertisements, and we have no other relationship with advertisers.

11. SERVICES MANAGEMENT
We reserve the right, but not the obligation, to: (1) monitor the Services for violations of these Legal Terms; (2) take appropriate legal action against anyone who, in our sole discretion, violates the law or these Legal Terms, including without limitation, reporting such user to law enforcement authorities; (3) in our sole discretion and without limitation, refuse, restrict access to, limit the availability of, or disable (to the extent technologically feasible) any of your Contributions or any portion thereof; (4) in our sole discretion and without limitation, notice, or liability, to remove from the Services or otherwise disable all files and content that are excessive in size or are in any way burdensome to our systems; and (5) otherwise manage the Services in a manner designed to protect our rights and property and to facilitate the proper functioning of the Services.

12. PRIVACY POLICY
We care about data privacy and security. Please review our Privacy Policy: https://topicscript.xyz. By using the Services, you agree to be bound by our Privacy Policy, which is incorporated into these Legal Terms. Please be advised the Services are hosted in the United States. If you access the Services from any other region of the world with laws or other requirements governing personal data collection, use, or disclosure that differ from applicable laws in the United States, then through your continued use of the Services, you are transferring your data to the United States, and you expressly consent to have your data transferred to and processed in the United States.

13. COPYRIGHT INFRINGEMENTS
We respect the intellectual property rights of others. If you believe that any material available on or through the Services infringes upon any copyright you own or control, please immediately notify us using the contact information provided below (a "Notification"). A copy of your Notification will be sent to the person who posted or stored the material addressed in the Notification. Please be advised that pursuant to applicable law you may be held liable for damages if you make material misrepresentations in a Notification. Thus, if you are not sure that material located on or linked to by the Services infringes your copyright, you should consider first contacting an attorney.

14. TERM AND TERMINATION
These Legal Terms shall remain in full force and effect while you use the Services. WITHOUT LIMITING ANY OTHER PROVISION OF THESE LEGAL TERMS, WE RESERVE THE RIGHT TO, IN OUR SOLE DISCRETION AND WITHOUT NOTICE OR LIABILITY, DENY ACCESS TO AND USE OF THE SERVICES (INCLUDING BLOCKING CERTAIN IP ADDRESSES), TO ANY PERSON FOR ANY REASON OR FOR NO REASON, INCLUDING WITHOUT LIMITATION FOR BREACH OF ANY REPRESENTATION, WARRANTY, OR COVENANT CONTAINED IN THESE LEGAL TERMS OR OF ANY APPLICABLE LAW OR REGULATION. WE MAY TERMINATE YOUR USE OR PARTICIPATION IN THE SERVICES OR DELETE YOUR ACCOUNT AND ANY CONTENT OR INFORMATION THAT YOU POSTED AT ANY TIME, WITHOUT WARNING, IN OUR SOLE DISCRETION.

If we terminate or suspend your account for any reason, you are prohibited from registering and creating a new account under your name, a fake or borrowed name, or the name of any third party, even if you may be acting on behalf of the third party. In addition to terminating or suspending your account, we reserve the right to take appropriate legal action, including without limitation pursuing civil, criminal, and injunctive redress.

15. MODIFICATIONS AND INTERRUPTIONS
We reserve the right to change, modify, or remove the contents of the Services at any time or for any reason at our sole discretion without notice. However, we have no obligation to update any information on our Services. We will not be liable to you or any third party for any modification, price change, suspension, or discontinuance of the Services.

We cannot guarantee the Services will be available at all times. We may experience hardware, software, or other problems or need to perform maintenance related to the Services, resulting in interruptions, delays, or errors. We reserve the right to change, revise, update, suspend, discontinue, or otherwise modify the Services at any time or for any reason without notice to you. You agree that we have no liability whatsoever for any loss, damage, or inconvenience caused by your inability to access or use the Services during any downtime or discontinuance of the Services. Nothing in these Legal Terms will be construed to obligate us to maintain and support the Services or to supply any corrections, updates, or releases in connection therewith.

16. GOVERNING LAW
These Legal Terms and your use of the Services are governed by and construed in accordance with the laws of the State of California applicable to agreements made and to be entirely performed within the State of California, without regard to its conflict of law principles.

17. DISPUTE RESOLUTION
Informal Negotiations
To expedite resolution and control the cost of any dispute, controversy, or claim related to these Legal Terms (each a "Dispute" and collectively, the "Disputes") brought by either you or us (individually, a "Party" and collectively, the "Parties"), the Parties agree to first attempt to negotiate any Dispute (except those Disputes expressly provided below) informally for at least thirty (30) days before initiating arbitration. Such informal negotiations commence upon written notice from one Party to the other Party.
Binding Arbitration
If the Parties are unable to resolve a Dispute through informal negotiations, the Dispute (except those Disputes expressly excluded below) will be finally and exclusively resolved by binding arbitration. YOU UNDERSTAND THAT WITHOUT THIS PROVISION, YOU WOULD HAVE THE RIGHT TO SUE IN COURT AND HAVE A JURY TRIAL. The arbitration shall be commenced and conducted under the Commercial Arbitration Rules of the American Arbitration Association ("AAA") and, where appropriate, the AAA’s Supplementary Procedures for Consumer Related Disputes ("AAA Consumer Rules"), both of which are available at the American Arbitration Association (AAA) website. Your arbitration fees and your share of arbitrator compensation shall be governed by the AAA Consumer Rules and, where appropriate, limited by the AAA Consumer Rules. The arbitration may be conducted in person, through the submission of documents, by phone, or online. The arbitrator will make a decision in writing, but need not provide a statement of reasons unless requested by either Party. The arbitrator must follow applicable law, and any award may be challenged if the arbitrator fails to do so. Except where otherwise required by the applicable AAA rules or applicable law, the arbitration will take place in San Francisco, California. Except as otherwise provided herein, the Parties may litigate in court to compel arbitration, stay proceedings pending arbitration, or to confirm, modify, vacate, or enter judgment on the award entered by the arbitrator.

If for any reason, a Dispute proceeds in court rather than arbitration, the Dispute shall be commenced or prosecuted in the  state and federal courts located in San Francisco, California, and the Parties hereby consent to, and waive all defenses of lack of personal jurisdiction, and forum non conveniens with respect to venue and jurisdiction in such state and federal courts. Application of the United Nations Convention on Contracts for the International Sale of Goods and the Uniform Computer Information Transaction Act (UCITA) are excluded from these Legal Terms.

In no event shall any Dispute brought by either Party related in any way to the Services be commenced more than one (1) years after the cause of action arose. If this provision is found to be illegal or unenforceable, then neither Party will elect to arbitrate any Dispute falling within that portion of this provision found to be illegal or unenforceable and such Dispute shall be decided by a court of competent jurisdiction within the courts listed for jurisdiction above, and the Parties agree to submit to the personal jurisdiction of that court.
Restrictions
The Parties agree that any arbitration shall be limited to the Dispute between the Parties individually. To the full extent permitted by law, (a) no arbitration shall be joined with any other proceeding; (b) there is no right or authority for any Dispute to be arbitrated on a class-action basis or to utilize class action procedures; and (c) there is no right or authority for any Dispute to be brought in a purported representative capacity on behalf of the general public or any other persons.
Exceptions to Informal Negotiations and Arbitration
The Parties agree that the following Disputes are not subject to the above provisions concerning informal negotiations binding arbitration: (a) any Disputes seeking to enforce or protect, or concerning the validity of, any of the intellectual property rights of a Party; (b) any Dispute related to, or arising from, allegations of theft, piracy, invasion of privacy, or unauthorized use; and (c) any claim for injunctive relief. If this provision is found to be illegal or unenforceable, then neither Party will elect to arbitrate any Dispute falling within that portion of this provision found to be illegal or unenforceable and such Dispute shall be decided by a court of competent jurisdiction within the courts listed for jurisdiction above, and the Parties agree to submit to the personal jurisdiction of that court.

18. CORRECTIONS
There may be information on the Services that contains typographical errors, inaccuracies, or omissions, including descriptions, pricing, availability, and various other information. We reserve the right to correct any errors, inaccuracies, or omissions and to change or update the information on the Services at any time, without prior notice.

19. DISCLAIMER
THE SERVICES ARE PROVIDED ON AN AS-IS AND AS-AVAILABLE BASIS. YOU AGREE THAT YOUR USE OF THE SERVICES WILL BE AT YOUR SOLE RISK. TO THE FULLEST EXTENT PERMITTED BY LAW, WE DISCLAIM ALL WARRANTIES, EXPRESS OR IMPLIED, IN CONNECTION WITH THE SERVICES AND YOUR USE THEREOF, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT. WE MAKE NO WARRANTIES OR REPRESENTATIONS ABOUT THE ACCURACY OR COMPLETENESS OF THE SERVICES' CONTENT OR THE CONTENT OF ANY WEBSITES OR MOBILE APPLICATIONS LINKED TO THE SERVICES AND WE WILL ASSUME NO LIABILITY OR RESPONSIBILITY FOR ANY (1) ERRORS, MISTAKES, OR INACCURACIES OF CONTENT AND MATERIALS, (2) PERSONAL INJURY OR PROPERTY DAMAGE, OF ANY NATURE WHATSOEVER, RESULTING FROM YOUR ACCESS TO AND USE OF THE SERVICES, (3) ANY UNAUTHORIZED ACCESS TO OR USE OF OUR SECURE SERVERS AND/OR ANY AND ALL PERSONAL INFORMATION AND/OR FINANCIAL INFORMATION STORED THEREIN, (4) ANY INTERRUPTION OR CESSATION OF TRANSMISSION TO OR FROM THE SERVICES, (5) ANY BUGS, VIRUSES, TROJAN HORSES, OR THE LIKE WHICH MAY BE TRANSMITTED TO OR THROUGH THE SERVICES BY ANY THIRD PARTY, AND/OR (6) ANY ERRORS OR OMISSIONS IN ANY CONTENT AND MATERIALS OR FOR ANY LOSS OR DAMAGE OF ANY KIND INCURRED AS A RESULT OF THE USE OF ANY CONTENT POSTED, TRANSMITTED, OR OTHERWISE MADE AVAILABLE VIA THE SERVICES. WE DO NOT WARRANT, ENDORSE, GUARANTEE, OR ASSUME RESPONSIBILITY FOR ANY PRODUCT OR SERVICE ADVERTISED OR OFFERED BY A THIRD PARTY THROUGH THE SERVICES, ANY HYPERLINKED WEBSITE, OR ANY WEBSITE OR MOBILE APPLICATION FEATURED IN ANY BANNER OR OTHER ADVERTISING, AND WE WILL NOT BE A PARTY TO OR IN ANY WAY BE RESPONSIBLE FOR MONITORING ANY TRANSACTION BETWEEN YOU AND ANY THIRD-PARTY PROVIDERS OF PRODUCTS OR SERVICES. AS WITH THE PURCHASE OF A PRODUCT OR SERVICE THROUGH ANY MEDIUM OR IN ANY ENVIRONMENT, YOU SHOULD USE YOUR BEST JUDGMENT AND EXERCISE CAUTION WHERE APPROPRIATE.

20. LIMITATIONS OF LIABILITY
IN NO EVENT WILL WE OR OUR DIRECTORS, EMPLOYEES, OR AGENTS BE LIABLE TO YOU OR ANY THIRD PARTY FOR ANY DIRECT, INDIRECT, CONSEQUENTIAL, EXEMPLARY, INCIDENTAL, SPECIAL, OR PUNITIVE DAMAGES, INCLUDING LOST PROFIT, LOST REVENUE, LOSS OF DATA, OR OTHER DAMAGES ARISING FROM YOUR USE OF THE SERVICES, EVEN IF WE HAVE BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. NOTWITHSTANDING ANYTHING TO THE CONTRARY CONTAINED HEREIN, OUR LIABILITY TO YOU FOR ANY CAUSE WHATSOEVER AND REGARDLESS OF THE FORM OF THE ACTION, WILL AT ALL TIMES BE LIMITED TO THE LESSER OF THE AMOUNT PAID, IF ANY, BY YOU TO US OR \$100.00 USD. CERTAIN US STATE LAWS AND INTERNATIONAL LAWS DO NOT ALLOW LIMITATIONS ON IMPLIED WARRANTIES OR THE EXCLUSION OR LIMITATION OF CERTAIN DAMAGES. IF THESE LAWS APPLY TO YOU, SOME OR ALL OF THE ABOVE DISCLAIMERS OR LIMITATIONS MAY NOT APPLY TO YOU, AND YOU MAY HAVE ADDITIONAL RIGHTS.

21. INDEMNIFICATION
You agree to defend, indemnify, and hold us harmless, including our subsidiaries, affiliates, and all of our respective officers, agents, partners, and employees, from and against any loss, damage, liability, claim, or demand, including reasonable attorneys’ fees and expenses, made by any third party due to or arising out of: (1) your Contributions; (2) use of the Services; (3) breach of these Legal Terms; (4) any breach of your representations and warranties set forth in these Legal Terms; (5) your violation of the rights of a third party, including but not limited to intellectual property rights; or (6) any overt harmful act toward any other user of the Services with whom you connected via the Services. Notwithstanding the foregoing, we reserve the right, at your expense, to assume the exclusive defense and control of any matter for which you are required to indemnify us, and you agree to cooperate, at your expense, with our defense of such claims. We will use reasonable efforts to notify you of any such claim, action, or proceeding which is subject to this indemnification upon becoming aware of it.

22. USER DATA
We will maintain certain data that you transmit to the Services for the purpose of managing the performance of the Services, as well as data relating to your use of the Services. Although we perform regular routine backups of data, you are solely responsible for all data that you transmit or that relates to any activity you have undertaken using the Services. You agree that we shall have no liability to you for any loss or corruption of any such data, and you hereby waive any right of action against us arising from any such loss or corruption of such data.

23. ELECTRONIC COMMUNICATIONS, TRANSACTIONS, AND SIGNATURES
Visiting the Services, sending us emails, and completing online forms constitute electronic communications. You consent to receive electronic communications, and you agree that all agreements, notices, disclosures, and other communications we provide to you electronically, via email and on the Services, satisfy any legal requirement that such communication be in writing. YOU HEREBY AGREE TO THE USE OF ELECTRONIC SIGNATURES, CONTRACTS, ORDERS, AND OTHER RECORDS, AND TO ELECTRONIC DELIVERY OF NOTICES, POLICIES, AND RECORDS OF TRANSACTIONS INITIATED OR COMPLETED BY US OR VIA THE SERVICES. You hereby waive any rights or requirements under any statutes, regulations, rules, ordinances, or other laws in any jurisdiction which require an original signature or delivery or retention of non-electronic records, or to payments or the granting of credits by any means other than electronic means.

24. CALIFORNIA USERS AND RESIDENTS
If any complaint with us is not satisfactorily resolved, you can contact the Complaint Assistance Unit of the Division of Consumer Services of the California Department of Consumer Affairs in writing at 1625 North Market Blvd., Suite N 112, Sacramento, California 95834 or by telephone at (800) 952-5210 or (916) 445-1254.

25. MISCELLANEOUS
These Legal Terms and any policies or operating rules posted by us on the Services or in respect to the Services constitute the entire agreement and understanding between you and us. Our failure to exercise or enforce any right or provision of these Legal Terms shall not operate as a waiver of such right or provision. These Legal Terms operate to the fullest extent permissible by law. We may assign any or all of our rights and obligations to others at any time. We shall not be responsible or liable for any loss, damage, delay, or failure to act caused by any cause beyond our reasonable control. If any provision or part of a provision of these Legal Terms is determined to be unlawful, void, or unenforceable, that provision or part of the provision is deemed severable from these Legal Terms and does not affect the validity and enforceability of any remaining provisions. There is no joint venture, partnership, employment or agency relationship created between you and us as a result of these Legal Terms or use of the Services. You agree that these Legal Terms will not be construed against us by virtue of having drafted them. You hereby waive any and all defenses you may have based on the electronic form of these Legal Terms and the lack of signing by the parties hereto to execute these Legal Terms.

26.ARTIFICIAL INTELLIGENCE AND AUTOMATED PROCESSING
A. Use of AI Technologies This application utilizes advanced artificial intelligence (AI), including large language models (LLMs), optical character recognition (OCR), and automated text extraction algorithms, to provide core features such as translation, vocabulary generation, and lesson compilation from user-uploaded materials.
B. Accuracy and "Hallucinations" Due to the probabilistic and experimental nature of AI technologies, particularly when processing complex, highly contextual, or low-resource languages (such as Pashto, Dari, and Russian), the system may occasionally generate output that is inaccurate, culturally inappropriate, or entirely fabricated (commonly known as "hallucinations"). You acknowledge and agree that all AI-generated content, translations, and lesson materials are provided "as is" for educational and personal learning purposes only. We disclaim any liability for errors in the AI-generated output, and you agree not to rely on this application for critical, professional, legal, medical, or financial translations.
C. Third-Party AI Providers To process your documents and deliver these features, your uploaded files and text queries are securely routed through third-party AI and cloud computing providers (including, but not limited to, Google Cloud and generative AI APIs). By using the application and uploading materials, you consent to your data being processed by these third-party services


27. RESEARCH RIGHTS

By using this application, you grant us a perpetual, royalty-free right to use anonymized and aggregated data derived from your interactions with the service for internal research, system telemetry, and product development. This includes, but is not limited to, analyzing usage patterns, generated vocabulary lists, and text extraction results to improve our optical character recognition (OCR) pipelines, enhance our automated translation and parsing models, and optimize our serverless data processing architecture. No personally identifiable information (PII) or raw, un-anonymized documents uploaded by you will be used for these research purposes or shared with third parties without your explicit, prior consent.

28. TRANSLATION AND ACCURACY DISCLAIMER
The translations, vocabulary extractions, lesson structures, and text parsing provided by this application are generated using automated algorithms, artificial intelligence, and optical character recognition (OCR) technologies. While we continuously strive to improve our systems, the automated processing of languages—including but not limited to Pashto, Dari, and Russian—may result in errors, omissions, incorrect formatting, or contextually inaccurate translations. The lesson materials generated from your uploaded PDFs or accessed via our provided libraries are intended strictly for educational and personal learning purposes. We make no warranties, express or implied, regarding the accuracy, cultural appropriateness, reliability, or completeness of any translated text or extracted grammar. You agree that you will not rely on these automated translations for legal, medical, financial, or other critical or professional purposes.
29. DATA RETENTION AND ANONYMIZATION
We retain your account information and synced progression data (such as your active libraries, user experience points, and handle) securely via our backend database only for as long as your account remains active or as necessary to provide you with seamless cross-device synchronization.
Regarding the document processing feature: PDFs or other materials you upload for lesson generation are stored on our secure cloud infrastructure. To continuously improve our optical character recognition (OCR) systems, language parsing models, and overall service reliability, we reserve the right to retain these uploaded source documents indefinitely.
In the event that you choose to delete your user account, any retained source files, text snippets, and telemetry data will be strictly disassociated from your profile and stripped of all personally identifiable information (PII). We reserve the right to indefinitely retain this fully anonymized, unlinked data solely for internal system health monitoring, research, and the ongoing training of our language processing pipelines

30. CONTACT US
In order to resolve a complaint regarding the Services or to receive further information regarding use of the Services, please contact us at:

Kangarule
westleydunn30@gmail.com

This Terms and Conditions was created using Termly's Terms and Conditions Generator

""";
const String ppLong = """
PRIVACY POLICY
Last updated April 10, 2023



This Privacy Notice for Kangarule ("we," "us," or "our"), describes how and why we might access, collect, store, use, and/or share ("process") your personal information when you use our services ("Services"), including when you:
Download and use our mobile application (Kangarule), or any other application of ours that links to this Privacy Notice
Use Kangarule. A language learning app currently implementing Russian.
Engage with us in other related ways, including any marketing or events
Questions or concerns? Reading this Privacy Notice will help you understand your privacy rights and choices. We are responsible for making decisions about how your personal information is processed. If you do not agree with our policies and practices, please do not use our Services. If you still have any questions or concerns, please contact us at kangaruleservice@gmail.com.


SUMMARY OF KEY POINTS
This summary provides key points from our Privacy Notice, but you can find out more details about any of these topics by clicking the link following each key point or by using our table of contents below to find the section you are looking for.

What personal information do we process? When you visit, use, or navigate our Services, we may process personal information depending on how you interact with us and the Services, the choices you make, and the products and features you use. Learn more about personal information you disclose to us.

Do we process any sensitive personal information? Some of the information may be considered "special" or "sensitive" in certain jurisdictions, for example your racial or ethnic origins, sexual orientation, and religious beliefs. We do not process sensitive personal information.

Do we collect any information from third parties? We do not collect any information from third parties.

How do we process your information? We process your information to provide, improve, and administer our Services, communicate with you, for security and fraud prevention, and to comply with law. We may also process your information for other purposes with your consent. We process your information only when we have a valid legal reason to do so. Learn more about how we process your information.

In what situations and with which types of parties do we share personal information? We may share information in specific situations and with specific categories of third parties. Learn more about when and with whom we share your personal information.

How do we keep your information safe? We have adequate organizational and technical processes and procedures in place to protect your personal information. However, no electronic transmission over the internet or information storage technology can be guaranteed to be 100% secure, so we cannot promise or guarantee that hackers, cybercriminals, or other unauthorized third parties will not be able to defeat our security and improperly collect, access, steal, or modify your information. Learn more about how we keep your information safe.

What are your rights? Depending on where you are located geographically, the applicable privacy law may mean you have certain rights regarding your personal information. Learn more about your privacy rights.

How do you exercise your rights? The easiest way to exercise your rights is by visiting com.literalomicus.kangarule, or by contacting us. We will consider and act upon any request in accordance with applicable data protection laws.

Want to learn more about what we do with any information we collect? Review the Privacy Notice in full.


TABLE OF CONTENTS
1. WHAT INFORMATION DO WE COLLECT?
2. HOW DO WE PROCESS YOUR INFORMATION?
3. WHAT LEGAL BASES DO WE RELY ON TO PROCESS YOUR PERSONAL INFORMATION?
4. WHEN AND WITH WHOM DO WE SHARE YOUR PERSONAL INFORMATION?
5. WHAT IS OUR STANCE ON THIRD-PARTY WEBSITES?
6. DO WE USE COOKIES AND OTHER TRACKING TECHNOLOGIES?
7. HOW DO WE HANDLE YOUR SOCIAL LOGINS?
8. HOW LONG DO WE KEEP YOUR INFORMATION?
9. HOW DO WE KEEP YOUR INFORMATION SAFE?
10. WHAT ARE YOUR PRIVACY RIGHTS?
11. CONTROLS FOR DO-NOT-TRACK FEATURES
12. DO UNITED STATES RESIDENTS HAVE SPECIFIC PRIVACY RIGHTS?
13. DO OTHER REGIONS HAVE SPECIFIC PRIVACY RIGHTS?
14. DO WE MAKE UPDATES TO THIS NOTICE?
15. HOW CAN YOU CONTACT US ABOUT THIS NOTICE?
16. HOW CAN YOU REVIEW, UPDATE, OR DELETE THE DATA WE COLLECT FROM YOU?


1. WHAT INFORMATION DO WE COLLECT?
Personal information you disclose to us
In Short: We collect personal information that you provide to us.

We collect personal information that you voluntarily provide to us when you register on the Services, express an interest in obtaining information about us or our products and Services, when you participate in activities on the Services, or otherwise when you contact us.

Personal Information Provided by You. The personal information that we collect depends on the context of your interactions with us and the Services, the choices you make, and the products and features you use. The personal information we collect may include the following:
email addresses
usernames
passwords
contact or authentication data
Sensitive Information. We do not process sensitive information.

Social Media Login Data. We may provide you with the option to register with us using your existing social media account details, like your Facebook, X, or other social media account. If you choose to register in this way, we will collect certain profile information about you from the social media provider, as described in the section called "HOW DO WE HANDLE YOUR SOCIAL LOGINS?" below.

Application Data. If you use our application(s), we also may collect the following information if you choose to provide us with access or permission:
Mobile Device Access. We may request access or permission to certain features from your mobile device, including your mobile device's microphone, storage, and other features. If you wish to change our access or permissions, you may do so in your device's settings.
Mobile Device Data. We automatically collect device information (such as your mobile device ID, model, and manufacturer), operating system, version information and system configuration information, device and application identification numbers, browser type and version, hardware model Internet service provider and/or mobile carrier, and Internet Protocol (IP) address (or proxy server). If you are using our application(s), we may also collect information about the phone network associated with your mobile device, your mobile device’s operating system or platform, the type of mobile device you use, your mobile device’s unique device ID, and information about the features of our application(s) you accessed.
Push Notifications. We may request to send you push notifications regarding your account or certain features of the application(s). If you wish to opt out from receiving these types of communications, you may turn them off in your device's settings.
This information is primarily needed to maintain the security and operation of our application(s), for troubleshooting, and for our internal analytics and reporting purposes.

All personal information that you provide to us must be true, complete, and accurate, and you must notify us of any changes to such personal information.
Information automatically collected
In Short: Some information — such as your Internet Protocol (IP) address and/or browser and device characteristics — is collected automatically when you visit our Services.

We automatically collect certain information when you visit, use, or navigate the Services. This information does not reveal your specific identity (like your name or contact information) but may include device and usage information, such as your IP address, browser and device characteristics, operating system, language preferences, referring URLs, device name, country, location, information about how and when you use our Services, and other technical information. This information is primarily needed to maintain the security and operation of our Services, and for our internal analytics and reporting purposes.

The information we collect includes:
Log and Usage Data. Log and usage data is service-related, diagnostic, usage, and performance information our servers automatically collect when you access or use our Services and which we record in log files. Depending on how you interact with us, this log data may include your IP address, device information, browser type, and settings and information about your activity in the Services (such as the date/time stamps associated with your usage, pages and files viewed, searches, and other actions you take such as which features you use), device event information (such as system activity, error reports (sometimes called "crash dumps"), and hardware settings).
Device Data. We collect device data such as information about your computer, phone, tablet, or other device you use to access the Services. Depending on the device used, this device data may include information such as your IP address (or proxy server), device and application identification numbers, location, browser type, hardware model, Internet service provider and/or mobile carrier, operating system, and system configuration information.
Location Data. We collect location data such as information about your device's location, which can be either precise or imprecise. How much information we collect depends on the type and settings of the device you use to access the Services. For example, we may use GPS and other technologies to collect geolocation data that tells us your current location (based on your IP address). You can opt out of allowing us to collect this information either by refusing access to the information or by disabling your Location setting on your device. However, if you choose to opt out, you may not be able to use certain aspects of the Services.
Google API
Our use of information received from Google APIs will adhere to Google API Services User Data Policy, including the Limited Use requirements.


2. HOW DO WE PROCESS YOUR INFORMATION?
In Short: We process your information to provide, improve, and administer our Services, communicate with you, for security and fraud prevention, and to comply with law. We process the personal information for the following purposes listed below. We may also process your information for other purposes only with your prior explicit consent.

We process your personal information for a variety of reasons, depending on how you interact with our Services, including:
To facilitate account creation and authentication and otherwise manage user accounts. We may process your information so you can create and log in to your account, as well as keep your account in working order.
To deliver and facilitate delivery of services to the user. We may process your information to provide you with the requested service.




To request feedback. We may process your information when necessary to request feedback and to contact you about your use of our Services.
To deliver targeted advertising to you. We may process your information to develop and display personalized content and advertising tailored to your interests, location, and more.
To protect our Services. We may process your information as part of our efforts to keep our Services safe and secure, including fraud monitoring and prevention.
To identify usage trends. We may process information about how you use our Services to better understand how they are being used so we can improve them.
To determine the effectiveness of our marketing and promotional campaigns. We may process your information to better understand how to provide marketing and promotional campaigns that are most relevant to you.
To save or protect an individual's vital interest. We may process your information when necessary to save or protect an individual’s vital interest, such as to prevent harm.

3. WHAT LEGAL BASES DO WE RELY ON TO PROCESS YOUR INFORMATION?
In Short: We only process your personal information when we believe it is necessary and we have a valid legal reason (i.e., legal basis) to do so under applicable law, like with your consent, to comply with laws, to provide you with services to enter into or fulfill our contractual obligations, to protect your rights, or to fulfill our legitimate business interests.

If you are located in the EU or UK, this section applies to you.

The General Data Protection Regulation (GDPR) and UK GDPR require us to explain the valid legal bases we rely on in order to process your personal information. As such, we may rely on the following legal bases to process your personal information:
Consent. We may process your information if you have given us permission (i.e., consent) to use your personal information for a specific purpose. You can withdraw your consent at any time. Learn more about withdrawing your consent.
Performance of a Contract. We may process your personal information when we believe it is necessary to fulfill our contractual obligations to you, including providing our Services or at your request prior to entering into a contract with you.
Legitimate Interests. We may process your information when we believe it is reasonably necessary to achieve our legitimate business interests and those interests do not outweigh your interests and fundamental rights and freedoms. For example, we may process your personal information for some of the purposes described in order to:
Develop and display personalized and relevant advertising content for our users
Analyze how our Services are used so we can improve them to engage and retain users
Support our marketing activities
Diagnose problems and/or prevent fraudulent activities
Understand how our users use our products and services so we can improve user experience
Legal Obligations. We may process your information where we believe it is necessary for compliance with our legal obligations, such as to cooperate with a law enforcement body or regulatory agency, exercise or defend our legal rights, or disclose your information as evidence in litigation in which we are involved.
Vital Interests. We may process your information where we believe it is necessary to protect your vital interests or the vital interests of a third party, such as situations involving potential threats to the safety of any person.

If you are located in Canada, this section applies to you.

We may process your information if you have given us specific permission (i.e., express consent) to use your personal information for a specific purpose, or in situations where your permission can be inferred (i.e., implied consent). You can withdraw your consent at any time.

In some exceptional cases, we may be legally permitted under applicable law to process your information without your consent, including, for example:
If collection is clearly in the interests of an individual and consent cannot be obtained in a timely way
For investigations and fraud detection and prevention
For business transactions provided certain conditions are met
If it is contained in a witness statement and the collection is necessary to assess, process, or settle an insurance claim
For identifying injured, ill, or deceased persons and communicating with next of kin
If we have reasonable grounds to believe an individual has been, is, or may be victim of financial abuse
If it is reasonable to expect collection and use with consent would compromise the availability or the accuracy of the information and the collection is reasonable for purposes related to investigating a breach of an agreement or a contravention of the laws of Canada or a province
If disclosure is required to comply with a subpoena, warrant, court order, or rules of the court relating to the production of records
If it was produced by an individual in the course of their employment, business, or profession and the collection is consistent with the purposes for which the information was produced
If the collection is solely for journalistic, artistic, or literary purposes
If the information is publicly available and is specified by the regulations
We may disclose de-identified information for approved research or statistics projects, subject to ethics oversight and confidentiality commitments

4. WHEN AND WITH WHOM DO WE SHARE YOUR PERSONAL INFORMATION?
In Short: We may share information in specific situations described in this section and/or with the following categories of third parties.

Vendors, Consultants, and Other Third-Party Service Providers. We may share your data with third-party vendors, service providers, contractors, or agents ("third parties") who perform services for us or on our behalf and require access to such information to do that work. We have contracts in place with our third parties, which are designed to help safeguard your personal information. This means that they cannot do anything with your personal information unless we have instructed them to do it. They will also not share your personal information with any organization apart from us. They also commit to protect the data they hold on our behalf and to retain it for the period we instruct.

The categories of third parties we may share personal information with are as follows:
Data Storage Service Providers
Performance Monitoring Tools
Product Engineering & Design Tools
Cloud Computing Services
Ad Networks

We also may need to share your personal information in the following situations:
Business Transfers. We may share or transfer your information in connection with, or during negotiations of, any merger, sale of company assets, financing, or acquisition of all or a portion of our business to another company.

5. WHAT IS OUR STANCE ON THIRD-PARTY WEBSITES?
In Short: We are not responsible for the safety of any information that you share with third parties that we may link to or who advertise on our Services, but are not affiliated with, our Services.

The Services may link to third-party websites, online services, or mobile applications and/or contain advertisements from third parties that are not affiliated with us and which may link to other websites, services, or applications. Accordingly, we do not make any guarantee regarding any such third parties, and we will not be liable for any loss or damage caused by the use of such third-party websites, services, or applications. The inclusion of a link towards a third-party website, service, or application does not imply an endorsement by us. We cannot guarantee the safety and privacy of data you provide to any third-party websites. Any data collected by third parties is not covered by this Privacy Notice. We are not responsible for the content or privacy and security practices and policies of any third parties, including other websites, services, or applications that may be linked to or from the Services. You should review the policies of such third parties and contact them directly to respond to your questions.

6. DO WE USE COOKIES AND OTHER TRACKING TECHNOLOGIES?
In Short: We may use cookies and other tracking technologies to collect and store your information.

We may use cookies and similar tracking technologies (like web beacons and pixels) to gather information when you interact with our Services. Some online tracking technologies help us maintain the security of our Services and your account, prevent crashes, fix bugs, save your preferences, and assist with basic site functions.

We also permit third parties and service providers to use online tracking technologies on our Services for analytics and advertising, including to help manage and display advertisements, to tailor advertisements to your interests, or to send abandoned shopping cart reminders (depending on your communication preferences). The third parties and service providers use their technology to provide advertising about products and services tailored to your interests which may appear either on our Services or on other websites.

To the extent these online tracking technologies are deemed to be a "sale"/"sharing" (which includes targeted advertising, as defined under the applicable laws) under applicable US state laws, you can opt out of these online tracking technologies by submitting a request as described below under section "DO UNITED STATES RESIDENTS HAVE SPECIFIC PRIVACY RIGHTS?"

Specific information about how we use such technologies and how you can refuse certain cookies is set out in our Cookie Notice.
Google Analytics
We may share your information with Google Analytics to track and analyze the use of the Services. To opt out of being tracked by Google Analytics across the Services, visit https://tools.google.com/dlpage/gaoptout. For more information on the privacy practices of Google, please visit the Google Privacy & Terms page.

7. HOW DO WE HANDLE YOUR SOCIAL LOGINS?
In Short: If you choose to register or log in to our Services using a social media account, we may have access to certain information about you.

Our Services offer you the ability to register and log in using your third-party social media account details (like your Facebook or X logins). Where you choose to do this, we will receive certain profile information about you from your social media provider. The profile information we receive may vary depending on the social media provider concerned, but will often include your name, email address, friends list, and profile picture, as well as other information you choose to make public on such a social media platform.

We will use the information we receive only for the purposes that are described in this Privacy Notice or that are otherwise made clear to you on the relevant Services. Please note that we do not control, and are not responsible for, other uses of your personal information by your third-party social media provider. We recommend that you review their privacy notice to understand how they collect, use, and share your personal information, and how you can set your privacy preferences on their sites and apps.

8. HOW LONG DO WE KEEP YOUR INFORMATION?
In Short: We keep your information for as long as necessary to fulfill the purposes outlined in this Privacy Notice unless otherwise required by law.

We will only keep your personal information for as long as it is necessary for the purposes set out in this Privacy Notice, unless a longer retention period is required or permitted by law (such as tax, accounting, or other legal requirements). No purpose in this notice will require us keeping your personal information for longer than the period of time in which users have an account with us.

When we have no ongoing legitimate business need to process your personal information, we will either delete or anonymize such information, or, if this is not possible (for example, because your personal information has been stored in backup archives), then we will securely store your personal information and isolate it from any further processing until deletion is possible.

9. HOW DO WE KEEP YOUR INFORMATION SAFE?
In Short: We aim to protect your personal information through a system of organizational and technical security measures.

We have implemented appropriate and reasonable technical and organizational security measures designed to protect the security of any personal information we process. However, despite our safeguards and efforts to secure your information, no electronic transmission over the Internet or information storage technology can be guaranteed to be 100% secure, so we cannot promise or guarantee that hackers, cybercriminals, or other unauthorized third parties will not be able to defeat our security and improperly collect, access, steal, or modify your information. Although we will do our best to protect your personal information, transmission of personal information to and from our Services is at your own risk. You should only access the Services within a secure environment.

10. WHAT ARE YOUR PRIVACY RIGHTS?
In Short: Depending on your state of residence in the US or in some regions, such as the European Economic Area (EEA), United Kingdom (UK), Switzerland, and Canada, you have rights that allow you greater access to and control over your personal information. You may review, change, or terminate your account at any time, depending on your country, province, or state of residence.

In some regions (like the EEA, UK, Switzerland, and Canada), you have certain rights under applicable data protection laws. These may include the right (i) to request access and obtain a copy of your personal information, (ii) to request rectification or erasure; (iii) to restrict the processing of your personal information; (iv) if applicable, to data portability; and (v) not to be subject to automated decision-making. If a decision that produces legal or similarly significant effects is made solely by automated means, we will inform you, explain the main factors, and offer a simple way to request human review. In certain circumstances, you may also have the right to object to the processing of your personal information. You can make such a request by contacting us by using the contact details provided in the section "HOW CAN YOU CONTACT US ABOUT THIS NOTICE?" below.

We will consider and act upon any request in accordance with applicable data protection laws.
 
If you are located in the EEA or UK and you believe we are unlawfully processing your personal information, you also have the right to complain to your Member State data protection authority or UK data protection authority.

If you are located in Switzerland, you may contact the Federal Data Protection and Information Commissioner.

Withdrawing your consent: If we are relying on your consent to process your personal information, which may be express and/or implied consent depending on the applicable law, you have the right to withdraw your consent at any time. You can withdraw your consent at any time by contacting us by using the contact details provided in the section "HOW CAN YOU CONTACT US ABOUT THIS NOTICE?" below.

However, please note that this will not affect the lawfulness of the processing before its withdrawal nor, when applicable law allows, will it affect the processing of your personal information conducted in reliance on lawful processing grounds other than consent.
Account Information
If you would at any time like to review or change the information in your account or terminate your account, you can:
Log in to your account settings and update your user account.
Upon your request to terminate your account, we will deactivate or delete your account and information from our active databases. However, we may retain some information in our files to prevent fraud, troubleshoot problems, assist with any investigations, enforce our legal terms and/or comply with applicable legal requirements.

If you have questions or comments about your privacy rights, you may email us at kangaruleservice@gmail.com.

11. CONTROLS FOR DO-NOT-TRACK FEATURES
Most web browsers and some mobile operating systems and mobile applications include a Do-Not-Track ("DNT") feature or setting you can activate to signal your privacy preference not to have data about your online browsing activities monitored and collected. At this stage, no uniform technology standard for recognizing and implementing DNT signals has been finalized. As such, we do not currently respond to DNT browser signals or any other mechanism that automatically communicates your choice not to be tracked online. If a standard for online tracking is adopted that we must follow in the future, we will inform you about that practice in a revised version of this Privacy Notice.

California law requires us to let you know how we respond to web browser DNT signals. Because there currently is not an industry or legal standard for recognizing or honoring DNT signals, we do not respond to them at this time.

12. DO UNITED STATES RESIDENTS HAVE SPECIFIC PRIVACY RIGHTS?
In Short: If you are a resident of California, Colorado, Connecticut, Delaware, Florida, Indiana, Iowa, Kentucky, Maryland, Minnesota, Montana, Nebraska, New Hampshire, New Jersey, Oregon, Rhode Island, Tennessee, Texas, Utah, or Virginia, you may have the right to request access to and receive details about the personal information we maintain about you and how we have processed it, correct inaccuracies, get a copy of, or delete your personal information. You may also have the right to withdraw your consent to our processing of your personal information. These rights may be limited in some circumstances by applicable law. More information is provided below.
Categories of Personal Information We Collect
The table below shows the categories of personal information we have collected in the past twelve (12) months. The table includes illustrative examples of each category and does not reflect the personal information we collect from you. For a comprehensive inventory of all personal information we process, please refer to the section "WHAT INFORMATION DO WE COLLECT?"

Category	Examples	Collected
A. Identifiers
Contact details, such as real name, alias, postal address, telephone or mobile contact number, unique personal identifier, online identifier, Internet Protocol address, email address, and account name

YES

B. Personal information as defined in the California Customer Records statute
Name, contact information, education, employment, employment history, and financial information

NO

C. Protected classification characteristics under state or federal law
Gender, age, date of birth, race and ethnicity, national origin, marital status, and other demographic data

NO

D. Commercial information
Transaction information, purchase history, financial details, and payment information

NO

E. Biometric information
Fingerprints and voiceprints

NO

F. Internet or other similar network activity
Browsing history, search history, online behavior, interest data, and interactions with our and other websites, applications, systems, and advertisements

YES

G. Geolocation data
Device location

NO

H. Audio, electronic, sensory, or similar information
Images and audio, video or call recordings created in connection with our business activities

YES

I. Professional or employment-related information
Business contact details in order to provide you our Services at a business level or job title, work history, and professional qualifications if you apply for a job with us

NO

J. Education Information
Student records and directory information

NO

K. Inferences drawn from collected personal information
Inferences drawn from any of the collected personal information listed above to create a profile or summary about, for example, an individual’s preferences and characteristics

NO

L. Sensitive personal Information		

NO


We may also collect other personal information outside of these categories through instances where you interact with us in person, online, or by phone or mail in the context of:
Receiving help through our customer support channels;
Participation in customer surveys or contests; and
Facilitation in the delivery of our Services and to respond to your inquiries.
We will use and retain the collected personal information as needed to provide the Services or for:
Category A - As long as the user has an account with us
Category F - As long as the user has an account with us
Category H - There is temporary audio and visual collected and used in this app and my other software, TopicAudio.
Sources of Personal Information
Learn more about the sources of personal information we collect in "WHAT INFORMATION DO WE COLLECT?"
How We Use and Share Personal Information
Learn more about how we use your personal information in the section, "HOW DO WE PROCESS YOUR INFORMATION?"

Will your information be shared with anyone else?

We may disclose your personal information with our service providers pursuant to a written contract between us and each service provider. Learn more about how we disclose personal information to in the section, "WHEN AND WITH WHOM DO WE SHARE YOUR PERSONAL INFORMATION?"

We may use your personal information for our own business purposes, such as for undertaking internal research for technological development and demonstration. This is not considered to be "selling" of your personal information.

We have not sold or shared any personal information to third parties for a business or commercial purpose in the preceding twelve (12) months. We have disclosed the following categories of personal information to third parties for a business or commercial purpose in the preceding twelve (12) months:














Category H. Audio, electronic, visual, and similar information
The categories of third parties to whom we disclosed personal information for a business or commercial purpose can be found under "WHEN AND WITH WHOM DO WE SHARE YOUR PERSONAL INFORMATION?"
Your Rights
You have rights under certain US state data protection laws. However, these rights are not absolute, and in certain cases, we may decline your request as permitted by law. These rights include:
Right to know whether or not we are processing your personal data
Right to access your personal data
Right to correct inaccuracies in your personal data
Right to request the deletion of your personal data
Right to obtain a copy of the personal data you previously shared with us
Right to non-discrimination for exercising your rights
Right to opt out of the processing of your personal data if it is used for targeted advertising (or sharing as defined under California’s privacy law), the sale of personal data, or profiling in furtherance of decisions that produce legal or similarly significant effects ("profiling")
Depending upon the state where you live, you may also have the following rights:
Right to access the categories of personal data being processed (as permitted by applicable law, including the privacy law in Minnesota)
Right to obtain a list of the categories of third parties to which we have disclosed personal data (as permitted by applicable law, including the privacy law in California, Delaware, and Maryland)
Right to obtain a list of specific third parties to which we have disclosed personal data (as permitted by applicable law, including the privacy law in Minnesota and Oregon)
Right to obtain a list of third parties to which we have sold personal data (as permitted by applicable law, including the privacy law in Connecticut)
Right to review, understand, question, and depending on where you live, correct how personal data has been profiled (as permitted by applicable law, including the privacy law in Connecticut and Minnesota)
Right to limit use and disclosure of sensitive personal data (as permitted by applicable law, including the privacy law in California)
Right to opt out of the collection of sensitive data and personal data collected through the operation of a voice or facial recognition feature (as permitted by applicable law, including the privacy law in Florida)
How to Exercise Your Rights
To exercise these rights, you can contact us by visiting com.literalomicus.kangarule, by emailing us at kangaruleservice@gmail.com, or by referring to the contact details at the bottom of this document.

Under certain US state data protection laws, you can designate an authorized agent to make a request on your behalf. We may deny a request from an authorized agent that does not submit proof that they have been validly authorized to act on your behalf in accordance with applicable laws.
Request Verification
Upon receiving your request, we will need to verify your identity to determine you are the same person about whom we have the information in our system. We will only use personal information provided in your request to verify your identity or authority to make the request. However, if we cannot verify your identity from the information already maintained by us, we may request that you provide additional information for the purposes of verifying your identity and for security or fraud-prevention purposes.

If you submit the request through an authorized agent, we may need to collect additional information to verify your identity before processing your request and the agent will need to provide a written and signed permission from you to submit such request on your behalf.
Appeals
Under certain US state data protection laws, if we decline to take action regarding your request, you may appeal our decision by emailing us at kangaruleservice@gmail.com. We will inform you in writing of any action taken or not taken in response to the appeal, including a written explanation of the reasons for the decisions. If your appeal is denied, you may submit a complaint to your state attorney general.
California "Shine The Light" Law
California Civil Code Section 1798.83, also known as the "Shine The Light" law, permits our users who are California residents to request and obtain from us, once a year and free of charge, information about categories of personal information (if any) we disclosed to third parties for direct marketing purposes and the names and addresses of all third parties with which we shared personal information in the immediately preceding calendar year. If you are a California resident and would like to make such a request, please submit your request in writing to us by using the contact details provided in the section "HOW CAN YOU CONTACT US ABOUT THIS NOTICE?"

13. DO OTHER REGIONS HAVE SPECIFIC PRIVACY RIGHTS?
In Short: You may have additional rights based on the country you reside in.

Australia and New Zealand
We collect and process your personal information under the obligations and conditions set by Australia's Privacy Act 1988 and New Zealand's Privacy Act 2020 (Privacy Act).

This Privacy Notice satisfies the notice requirements defined in both Privacy Acts, in particular: what personal information we collect from you, from which sources, for which purposes, and other recipients of your personal information.

If you do not wish to provide the personal information necessary to fulfill their applicable purpose, it may affect our ability to provide our services, in particular:
offer you the products or services that you want
respond to or help with your requests
manage your account with us
confirm your identity and protect your account
At any time, you have the right to request access to or correction of your personal information. You can make such a request by contacting us by using the contact details provided in the section "HOW CAN YOU REVIEW, UPDATE, OR DELETE THE DATA WE COLLECT FROM YOU?"

If you believe we are unlawfully processing your personal information, you have the right to submit a complaint about a breach of the Australian Privacy Principles to the Office of the Australian Information Commissioner and a breach of New Zealand's Privacy Principles to the Office of New Zealand Privacy Commissioner.
Republic of South Africa
At any time, you have the right to request access to or correction of your personal information. You can make such a request by contacting us by using the contact details provided in the section "HOW CAN YOU REVIEW, UPDATE, OR DELETE THE DATA WE COLLECT FROM YOU?"

If you are unsatisfied with the manner in which we address any complaint with regard to our processing of personal information, you can contact the office of the regulator, the details of which are:

The Information Regulator (South Africa)
General enquiries: enquiries@inforegulator.org.za
Complaints (complete POPIA/PAIA form 5): PAIAComplaints@inforegulator.org.za & POPIAComplaints@inforegulator.org.za

14. DO WE MAKE UPDATES TO THIS NOTICE?
In Short: Yes, we will update this notice as necessary to stay compliant with relevant laws.

We may update this Privacy Notice from time to time. The updated version will be indicated by an updated "Revised" date at the top of this Privacy Notice. If we make material changes to this Privacy Notice, we may notify you either by prominently posting a notice of such changes or by directly sending you a notification. We encourage you to review this Privacy Notice frequently to be informed of how we are protecting your information.

15. HOW CAN YOU CONTACT US ABOUT THIS NOTICE?
If you have questions or comments about this notice, you may email us at kangaruleservice@gmail.com or contact us by post at:

Kangarule
__________
__________
United States

16. HOW CAN YOU REVIEW, UPDATE, OR DELETE THE DATA WE COLLECT FROM YOU?
Based on the applicable laws of your country or state of residence in the US, you may have the right to request access to the personal information we collect from you, details about how we have processed it, correct inaccuracies, or delete your personal information. You may also have the right to withdraw your consent to our processing of your personal information. These rights may be limited in some circumstances by applicable law. To request to review, update, or delete your personal information, please visit: com.literalomicus.kangarule.
""";
bool _active = false;
const Color darkBlue = Color.fromARGB(255, 18, 32, 47);
var uuid = Uuid();
List<T> flatten<T>(List<dynamic> list) => [for (var sublist in list) ...sublist];

// Define the filename for your JSON data
const String _jsonFileName = 'findmyNotebook.json';
Map<String, dynamic> NB =  {
  "Welcome":
  {
    "saved"
        : [
      [
        0, "This is your notebook! You can add to me by going to your lessons (available from the Home page) and clicking save to Notebook"
      ],
      [
        0, "Try clicking on the circle to the left of me to change my color. Don't worry about setting the text and background color, they automatically compliment each other so the text is always visible"
      ],
      [0, "Cleaning me is as simple as swiping right! Tired of seeing this tutorial? Swipe all these tiles away and when you revisit the empty topic will be gone!"
      ]
    ]
  }
};

Future<String?> readLANGPREF() async {
  //my_lang_pref
  final prefs = await SharedPreferences.getInstance();
  
  // 2. Read the value using the exact same key.
//  String? savedName = prefs.getString('lang_pref');
  String safeName = prefs.getString('lang_pref') ?? 'ru';
 return safeName;
  }


// 1. Helper to get the correct file based on WHO is logged in
Future<File> _getLocalFile(String userId) async {
  final directory = await getApplicationDocumentsDirectory();
  
  // Creates a unique file per user: "user123_findmyNotebook.json"
  // OR for guests: "guest_findmyNotebook.json"
  return File('${directory.path}/${userId}_$_jsonFileName');
}

// 2. Updated Save: Now accepts a userId
Future<void> saveNestedJsonToFile(Map<String, dynamic> data, String userId) async {
  try {
    // Pass the userId to get the correct file
    final file = await _getLocalFile(userId);

    String jsonString = jsonEncode(data);
    await file.writeAsString(jsonString);

    print('Saved notebook for user ($userId) to ${file.path}');
  } catch (e) {
    print('Error saving data for user ($userId): $e');
  }
}

// 3. Updated Load: Now accepts a userId ------------xd------------
Future<Map<String, dynamic>?> loadNestedJsonFromFile(String userId) async {
  try {
    // Pass the userId to get the correct file
    final file = await _getLocalFile(userId);

    if (await file.exists()) {
      String jsonString = await file.readAsString();

      if (jsonString.isEmpty) return null;

      Map<String, dynamic> data = jsonDecode(jsonString);
      print('Loaded notebook for user ($userId)');
      return data;
    } else {
      print('No notebook found for user ($userId). Creating new one...');
      return null;
    }
  } catch (e) {
    print('Error loading data for user ($userId): $e');
    return null;
  }
}


ThemeData GreenLight = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.green,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
ThemeData GreenDark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.green[700],
  visualDensity: VisualDensity.adaptivePlatformDensity,
);



// Ensure your global 'termsOfUse' variable is accessible here 
// (e.g., imported from your constants file)

class TermsOfUseDialog extends StatelessWidget {
  /// If true, shows [Decline] and [Agree & Continue]. 
  /// If false, shows only a [Close] button.
  final bool requireAgreement;
  
  /// The function to run if they click "Agree & Continue"
  final VoidCallback? onAgreed;

  const TermsOfUseDialog({
    Key? key,
    required this.requireAgreement,
    this.onAgreed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Terms of Use & Privacy Policy"),
      // The SizedBox is required to prevent the ScrollView from crashing the dialog
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            // Removed 'const' so the global variable can be injected
            children: [
              Text(termsOfUse), 
            ],
          ),
        ),
      ),
      actions: [
        // DYNAMIC BUTTONS LOGIC
        if (requireAgreement) ...[
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Dismisses dialog
            child: const Text("Decline", style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Dismisses dialog first
              if (onAgreed != null) onAgreed!(); // Triggers your signup/continue logic
            },
            child: const Text("Agree & Continue"),
          ),
        ] else ...[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Close"),
          ),
        ],
      ],
    );
  }
}

class ThemeProvider with ChangeNotifier {
  ThemeData currentTheme = GreenLight;


  ThemeData get _currentTheme => currentTheme;


  void switchTheme() {
    currentTheme == GreenLight
        ? currentTheme = GreenDark
        : currentTheme = GreenLight;
    notifyListeners();
  }
}

class AdaptiveTextSize {
  const AdaptiveTextSize();

  getadaptiveTextSize(BuildContext context, dynamic value) {
    // 720 is medium screen height
    return (value / 720) * MediaQuery.of(context).size.height;
  }
}
class StateMgmt extends StatefulWidget { // Standard class naming convention
  // Fields that are passed to the constructor belong here
  const StateMgmt({ // Make the constructor for the Widget class
    Key? key,
    required this.isLoading,
    this.Child = const SizedBox(), // Make Child optional with a default value (e.g., an empty SizedBox)
  }) : super(key: key);

  final bool isLoading;
  final Widget Child; // Define Child as a property of the Widget class

  @override
  // Correct createState method signature
  State<StateMgmt> createState() => _StateMgmtState();
}

class _StateMgmtState extends State<StateMgmt> {
  // State variables that change over time belong here
 // InterstitialAd? _interstitialAd; // Nullable InterstitialAd instance (Assuming this is state)
  bool startedAd  = false;
  // TODO: Replace this with your own interstitial ad unit ID for production
  // Use test IDs during development!
//  String get _adUnitId {
  //    return 'ca-app-pub-5815053066312487/1427329368'; // Test Android Interstitial}

  @override
  void initState() {
    super.initState();
    // Load the interstitial ad when the widget is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Get the Referencer model instance and call its load method
      // listen: false because we only want to call a method, not rebuild this State object
      try {
        Provider.of<Referencer>(context, listen: false)._loadInterstitialAd();
      }
      catch (e) {
        print("THIS IS THE PROBLEM");
      }
   });
  }
  @override
  void dispose() {
    // No ad disposal needed directly in this State anymore
    super.dispose();
  }
  // Loads the interstitial ad

 // const LoadingWithStateMgmt({
  //  Key? key,
  //  required this.isLoading,
 //   required this.Child,
 // }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // --- This is where you "Get the model instance (provided higher up)" ---
    // Providerof<MyDataModel>(context) looks UP the tree from this widget's context
    // to find the nearest MyDataModel instance provided by a Provider.
    // The 'listen: false' is important here because we only want to CALL a method (loadData)
    context.read<Referencer>().set_Notebook();

    return Scaffold(
        appBar: AppBar(title: Text('Kangarule')),
        body: Center(
          // Use a Consumer or another Provider.of (with listen: true or context.watch)
          // if the widget *itself* needs to rebuild when the state changes.
          // In this case, we'll use a Consumer to react to isLoading changes.

          child: Consumer<Referencer>(
            builder: (context, model, child) {
              return
                // If showContinueButton is true (ad is done/failed), show the Image and the Continue button
                Column(
                  children: [
                    // Other widgets...
                    Expanded( // Or Flexible()
                      child: Image(
                          image: AssetImage('assets/pics/movetopics.jpg')),
                    ),
                    SizedBox(
                      width: double.infinity,
                      // Make the SizedBox take the full available width
                      child: ElevatedButton(
                        onPressed: () {
                         if (startedAd == false) { //model.showContinueButton
                         //     ?
                          model._showInterstitialAd(
                            onAdDismissed: () {
   Navigator.of(context).push(
                             MaterialPageRoute(
                                 builder: (context) => widget.Child
                              )
                         );
    }
                          );
                           startedAd = true;
                          //    :
                         }
                        //  Navigator.of(context).push(
                         //     MaterialPageRoute(
                         //         builder: (context) => widget.Child
                         //     )
                       //   );
                        },
                        child: const Text('Continue'),
                      ),
                    ),
                    // Other widgets...
                  ],
                );
              }
          ),
        )
    );


  }
}
Future<void> _showReportDialog(BuildContext context) async {
  // Controller to retrieve the text the user types
  final TextEditingController reportController = TextEditingController();

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap a button to close
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Submit Report'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const Text('Please describe the issue or feedback:'),
              const SizedBox(height: 10),
              TextField(
                controller: reportController,
                maxLines: 4, // Makes the box taller for detailed input
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Type here...',
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          // CANCEL BUTTON
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); // Just close the dialog
            },
          ),
          // SUBMIT BUTTON
          ElevatedButton(
            child: const Text('Submit'),
            onPressed: () {
              String userMessage = reportController.text;
              
              if (userMessage.isNotEmpty) {
                // TODO: Add your Firebase logic here
                print("User reported: $userMessage");
                
                // Example: Write to Firestore for the 'Trigger Email' extension
                /*
                FirebaseFirestore.instance.collection('mail').add({
                  'to': 'support@kangarule.com',
                  'message': {
                    'subject': 'New User Report',
                    'text': userMessage,
                  },
                });
                */
              }

              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}

DatabaseReference ref = FirebaseDatabase.instance.ref('language');
enum PipelineState { idle, uploading, approving, downloading, done, error }

class Referencer extends ChangeNotifier {
  // 1. Define the global list (change 'dynamic' to your actual data type if you have one)
  List lemmyx =[{"display": "Russian/ Русский", "langx":"ru", "message": "the library source for Russian", "attribute": "Thanks to all my friends in Kazakhstan and Kyrgyzstan!"}, {"langx": "Pashto", "display": "Pashto", "message": "The library source for Pashto.", "attribute": "Beginning Pashto Textbook Revised Edition by Habibullah Tegey, Barbara Robson license: Public Domain"}, {"langx": "ItalianFSI", "display": "Italian", "message": "the library source for Italian", "attribute": "Italian FAST Course by Francesca Randazzo-Woodrow, Stephen Zappala, Egle Camozzo, Anna Fiore, Elizabeth Knutson license: Public Domain"}, {"langx": "Gerx", "display": "German", "message": "the library source for German.", "attribute": "German 101 by Rebecca Linam license_type: CC BY"}, {"langx": "Hindix", "display": "Hindi", "message": "the library source for Hindi.", "attribute": "Basic Hindi I by Rajiv Ranjan license: CC BY"} ];

  InterstitialAd? _interstitialAd; // Private field for the ad object
  bool _isAdLoaded = false; // Private field for ad loaded state
  bool _showContinueButton = false; // Private field for showing continue button
  Map<String, dynamic>? loadedData;

  // TODO: Replace with your actual interstitial ad unit ID
 //I NEEEEEEEEEEEEEED TO CHANGE THIS BACK LANGUAGE AGNOSTIC
  final String _adUnitId = 'ca-app-pub-3940256099942544/4411468910'; //'ca-app-pub-5815053066312487/1427329368'; // Test ad unit ID

  // Public getters to access the state from widgets
  bool get isAdLoaded => _isAdLoaded;
  //I DON'T THINK THIS IS PROPERLY IMPLEMENTED CHECC HERE
  bool get showContinueButton => _showContinueButton;

  //just the userinfo
  Map info = {};
  bool _isLoading = false;
  bool get isLoading => _isLoading;
 // Map socialite = {};
  List photo = ["1", "RU"];
  List whenReady = List.empty(growable: true);
  String ULTIMATELANGUAGE = "IntroPashtx";

  //this ^^^ is for the list of status ids per user
  //late int saveUser;
  //this
  //is
  //harcdoed
  //dont leave this
  String saveUser = "1";
  // late final String saveUser;

//change this
  int exp = 0;
  bool anonTag = false;

  //before
  //production

  late Map Notebook;
  Map Lemx = {};
// String my_lang_pref = 'ru';
 //I think HAVING THIS HERE WILL RESET EVERY LAUNCH BUT I CAN KEEP IT HERE IN CASE

  // late int exp;


  Map get _info => info;
  Map get _Lemx => Lemx;

 // Map get _socialite => socialite;

  List get _whenReady => whenReady;

  BannerAd? _bannerAd;
  bool _isBAdLoaded = false;

  BannerAd? get bannerAd => _bannerAd;
  bool get isBAdLoaded => _isAdLoaded;
  String uid = "";
  PipelineState currentTaskState = PipelineState.idle;
  String? activeLesson; 
  bool _isCancelled = false;

  // ==========================================
  // DETERMINE DOWNLOAD SOURCE (Library vs Directory)
  // ==========================================
  Map<String, String> determineSource() {
    int targetIndex = lemmyx.indexWhere(
      (element) => element['langx'] == ULTIMATELANGUAGE
    );

    // 2. Safely grab the dictionary using that index. 
    // If targetIndex is -1 (not found), we provide an empty map {} as a fallback.
    final targetLangDict = targetIndex != -1 ? lemmyx[targetIndex] : {};

    // 3. Extract the message and the langx code
    String message = targetLangDict['message']?.toString() ?? "";
    String backendLangx = targetLangDict['langx']?.toString() ?? ULTIMATELANGUAGE;
    String folderName = targetLangDict['display']?.toString() ?? "SOMETHINGWENTWRONG";
    // Assuming ULTIMATELANGUAGE is an integer index saved in your class. 
    // If it's passed in, just add it as an argument: determineSource(int ULTIMATELANGUAGE)
    
    // 1. Direct lookup in lemmyx! No loops, no searching.
  //  String message = lemmyx[ULTIMATELANGUAGE]['message']?.toString() ?? "";
  //  String backendLangx = lemmyx[ULTIMATELANGUAGE]['langx']?.toString() ?? "";
    
    String backendUserId;

    // 2. Check for "library"
    if (message.toLowerCase().contains('library')) {
      backendUserId = "000A"; 
    } else {
      backendUserId = uid ?? ""; 
    }

    // 3. Return the exact uid and the langx string
    return {
      'uid': backendUserId,
      'lang': backendLangx, 
     "foldername": folderName
    };
  }
  // ==========================================
  // SOURCE FROM FIREBASE (Realtime Database)
  // ==========================================
  Future<void> sourceFromFirebase() async {
    try {
      DataSnapshot snapshot = await ref.get();
      
      if (snapshot.exists && snapshot.value != null) {
        // Use a temporary list so we don't clear lemmyx if the parse fails
        List<Map<String, dynamic>> tempList = [];
        final rawData = snapshot.value;

        // Handle if Firebase stored it as a Dictionary (Map)
        if (rawData is Map) {
          rawData.forEach((key, value) {
            if (value is Map) {
              Map<String, dynamic> safeMap = {};
              value.forEach((vKey, vValue) {
                safeMap[vKey.toString()] = vValue;
              });
              tempList.add(safeMap);
            }
          });
        } 
        // Handle if Firebase stored it as an Array (List)
        else if (rawData is List) {
          for (var item in rawData) {
            if (item is Map) {
              Map<String, dynamic> safeMap = {};
              item.forEach((vKey, vValue) {
                safeMap[vKey.toString()] = vValue;
              });
              tempList.add(safeMap);
            }
          }
        }

        // Apply the newly parsed data
        if (tempList.isNotEmpty) {
          lemmyx.clear();
          lemmyx.addAll(tempList);
          notifyListeners();
        }
      }
    } catch (e) {
      print("Error sourcing data: $e");
    }
  }

  // ==========================================
  // SAVE TO FIREBASE (Realtime Database)
  // ==========================================
  Future<void> saveToFirebase() async {
    try {
      Map<String, dynamic> updates = {};
      
      for (var attributeMap in lemmyx) {
        // Prevent crashes by ensuring the 'display' key actually exists
        if (attributeMap.containsKey('display') && attributeMap['display'] != null) {
          // Firebase RTDB crashes if keys contain '/'
          String safeKey = attributeMap['display'].toString().replaceAll('/', '_');
          updates[safeKey] = attributeMap;
        }
      }
      
      if (updates.isNotEmpty) {
        await ref.update(updates);
      }
      
    } catch (e) {
      print("Realtime Database save failed: $e");
    }
  }

 void setCurrentLanguage(String newLanguage) {
    ULTIMATELANGUAGE = newLanguage;
    ref.child('ru/users/$saveUser/info/currentLanguage').set(newLanguage);
    notifyListeners();
  }
 
  void cancelPipeline() async {
    _isCancelled = true;
    currentTaskState = PipelineState.idle;
    activeLesson = null;
    notifyListeners(); 
    
    // Wipe the bookmark so it doesn't try to resume on next startup
    var box = await Hive.openBox('settingsBox');
    await box.delete('pending_document');
  }

 Future<void> recoverPendingTask() async {
    var box = await Hive.openBox('settingsBox');
    String? pendingLesson = box.get('pending_document');

    //await _triggerExtraction(uid!, 'WRONG WAY'); // Example language code

    if (pendingLesson != null) {
      // The app woke up and found a ghost task!
      activeLesson = pendingLesson;
      //currentTaskState = PipelineState.approving; // Jump straight to "Processing"
     // notifyListeners();

      // Resume the polling loop
    //  _pollAndDownload(pendingLesson);
    }
  }

 Future<Map<String, dynamic>> _triggerExtraction(String uid) async {
    // Using your FastAPI domain
    var uri = Uri.https('toknlicensex-220938151994.us-central1.run.app', '/trigger-extraction');
    
    var response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'uid': uid
       // 'filename': 'source.pdf' // Hardcoded based on our earlier setup
      }),
    ).timeout(const Duration(seconds: 90));
    if (response.statusCode == 451) {
        snackbarKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("THIS LICENSE IS NOT ACCEPTED!"),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating, // Makes it look clean and modern
          duration: const Duration(seconds: 5), // Gives them time to read it
        ),
      );
      //rethrow;
      } 
    if (response.statusCode != 200) {
      throw Exception("Failed to trigger backend extraction: ${response.body}");
    }
    
    // If it's a 200 OK, FastAPI successfully wrote "PROCESSING" to status.json 
    // and fired off the background workers!
    return jsonDecode(response.body);
  }

 Future<void> startHeavyPipeline(String filePath) async {
    _isCancelled = false;
    activeLesson = "source.pdf"; // Keeps your AlertDialog UI from breaking
    
    currentTaskState = PipelineState.uploading;
    notifyListeners(); 
    
    try {
      // --- 1. Get the Signed URL from FastAPI ---
      var getUrlUri = Uri.https('toknlicensex-220938151994.us-central1.run.app', '/get-upload-url'); 
      var getUrlResponse = await http.post(
        getUrlUri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'uid': uid, // Just the uid now!
         'filename': 'source',
        }),
      ).timeout(const Duration(seconds: 15)); // Add a timeout to prevent infinite hangs

      // Handle the specific ValueError exceptions raised by your Python script
      if (getUrlResponse.statusCode == 429) {
        snackbarKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("Tokens exhausted! Please try again next week."),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating, // Makes it look clean and modern
          duration: const Duration(seconds: 5), // Gives them time to read it
        ),
      );
      //rethrow;
      } else if (getUrlResponse.statusCode != 200) {
        throw Exception("Server rejected URL request: ${getUrlResponse.body}");
      }

      String signedUrl = jsonDecode(getUrlResponse.body)['upload_url'];

      if (_isCancelled) return;

      // --- 2. Stream directly to Google Cloud Storage ---
      File pdfFile = File(filePath);
      final bytes = await pdfFile.readAsBytes();
      final uploadResponse = await http.put(
        Uri.parse(signedUrl),
        headers: { 'Content-Type': 'application/pdf' },
        body: bytes, 
      );
      
      if (uploadResponse.statusCode != 200) {
        throw Exception("Direct bucket upload failed. Status: ${uploadResponse.statusCode}");
      }

      currentTaskState = PipelineState.approving;
      notifyListeners();

      // Optional: Clean up the OS temp file to save phone storage
   //   if (await pdfFile.exists()) { await pdfFile.delete(); }

      if (_isCancelled) return; 

      // --- 3. Save bookmark and start polling ---
     //THERES REALLY NO REASON 4 THIS I DONT UNDERSTAND CAUSE 4 CONCERN
      var box = await Hive.openBox('settingsBox');
      await box.put('pending_document', 'source.pdf');
      Map<String, dynamic> metadata = await _triggerExtraction(uid!); 
      var lBox = await Hive.openBox("lessonsBox");
      String documentNameToDisplay = metadata['title'] ?? "Unktle";
      String author = metadata['author'] ?? "Unhor";
      String license = metadata['license'] ?? "Unknowse";
      String reglang = metadata["language"] ?? "MISS!";
      String ULTIMATELANGUAGE = metadata["ultimatelangx"] ?? "MISS!";
     //CHECK TO MAKE SURE IF APP UNINSTALLED LANG CAM STILL B FOUMD
      String slicedDocument = documentNameToDisplay.length > 10 ? documentNameToDisplay.substring(0, 10) : documentNameToDisplay;
      String slicedAuthor = author.length > 15 ? author.substring(0, 15) : author;
      String slicedLicense = license.length > 5 ? license.substring(0, 5) : license;
      //NOW UPDATE THE TOOLTIP WRONGX
      // Notify listeners so the AlertDialog title instantly changes from 
      // "Processing source.pdf" to "Processing [Actual Textbook Name]"
      await lBox.put(ULTIMATELANGUAGE, {});
      addToLemmyx({"display":"$reglang", "langx": "$ULTIMATELANGUAGE", "message": "$slicedAuthor $slicedDocument $slicedLicense", "attribute": "placeholder"}, true);
      currentTaskState = PipelineState.done;
      notifyListeners();
      //await _pollAndDownload(ULTIMATELANGUAGE);

    } catch (e) {
      currentTaskState = PipelineState.error; 
      notifyListeners();
      
      // 1. Update the state (this pops the dialog we set up)
      currentTaskState = PipelineState.error; 
      notifyListeners(); 
      
      // 2. Shoot the error directly to the user's screen
      snackbarKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceAll('Exception: ', '')),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating, // Makes it look clean and modern
          duration: const Duration(seconds: 5), // Gives them time to read it
        ),
      );
      //rethrow;
    }
  }

  Future<void> _pollAndDownload(String documentName) async {
    currentTaskState = PipelineState.approving;
    notifyListeners(); 
    
    try {
      bool isProcessingComplete = false;
     //CAN THIS EVER COMPLETE?

      while (!isProcessingComplete && !_isCancelled) {
        // FIX 1: Removed 'https://' from the domain string!
       // var pollUri = Uri.https('toknlicensex-220938151994.us-central1.run.app', '/check-status', {
        //  'uid': uid!, 
       // });
        
       // var statusResponse = await http.get(pollUri).timeout(const Duration(seconds: 15));
        var pollUri = Uri.https('toknlicensex-220938151994.us-central1.run.app', '/check-status');
        var statusResponse = await http.post(
          pollUri,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'uid': uid, 'lang': documentName}), // 2. Send the uid in the body
        ).timeout(const Duration(seconds: 15));
        if (statusResponse.statusCode == 200) {
          var statusData = jsonDecode(statusResponse.body);
          
          if (statusData['overall_status'] == 'SUCCESS' || statusData['overall_status'] == 'COMPLETE') {
            isProcessingComplete = true; 
          } else if (statusData['overall_status'] == 'FAILED') {
            throw Exception("Worker scripts failed: ${statusData['error']}");
          }
        }
        
        // Pause before checking again so we don't spam Google Cloud
        if (!isProcessingComplete) {
          await Future.delayed(const Duration(seconds: 30));
          if (_isCancelled) return;
        }
      } // <--- End of while loop

      if (_isCancelled) return;

      // ==========================================
      // CLEAN UP MEMORY & PASS BATON
      // ==========================================
      var box = await Hive.openBox('settingsBox');
      await box.delete('pending_task');

      currentTaskState = PipelineState.downloading;
      notifyListeners();

    } catch (e) {
      currentTaskState = PipelineState.error; 
      notifyListeners();
      
      // 1. Update the state (this pops the dialog we set up)
      currentTaskState = PipelineState.error; 
      notifyListeners(); 
      
      // 2. Shoot the error directly to the user's screen
      snackbarKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceAll('Exception: ', '')),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating, // Makes it look clean and modern
          duration: const Duration(seconds: 5), // Gives them time to read it
        ),
      );
    }
  }
  
  // 2. This is the function you requested.
  void setUser(String newUid) {
    uid = newUid;
    
    // Optional: Call this only if the UI needs to rebuild 
    // immediately after setting the ID. If you are just setting 
    // it to use inside 'changi' right after, you don't need this.
   // notifyListeners(); 
  }

  // Method to load the banner ad
// Method to load the banner ad
  // Accepts callbacks to communicate loading status back to the widget.
  void loadBannerAd({
    required BuildContext context,
    required Function(BannerAd) onAdLoadedCallback,
    required Function(LoadAdError) onAdFailedToLoadCallback,
  }) {
    debugPrint('Referencer: loadBannerAd called.');
    // Dispose of any existing ad before loading a new one
    _bannerAd?.dispose();
    _bannerAd = null; // Clear the old ad instance
    // No notifyListeners() here

    // Get the appropriate ad unit ID based on the platform
    String adUnitId;
    try {
      adUnitId = 'ca-app-pub-5815053066312487/9845182927'; // Assuming AdHelper can get platform or you pass it
    } catch (e) {
      debugPrint('Referencer: Failed to get ad unit ID: $e');
      // Call the failure callback directly if ad unit ID can't be determined
      // Pass a dummy error or handle appropriately
      //onAdFailedToLoadCallback(LoadAdError(0, 'Failed to get ad unit ID', 'domain'));
      return; // Stop loading
    }


    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: AdRequest(),
      size: AdSize.banner, // Choose an appropriate size
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('Referencer: Ad loaded.');
          // Call the provided callback instead of notifyListeners()
          onAdLoadedCallback(ad as BannerAd); // Cast is safe here
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Referencer: Ad failed to load: $error');
          ad.dispose();
          _bannerAd = null; // Clear the ad instance on failure
          // Call the provided callback instead of notifyListeners()
          onAdFailedToLoadCallback(error);
        },
        onAdOpened: (ad) => debugPrint('Referencer: Ad opened.'),
        onAdClosed: (ad) => debugPrint('Referencer: Ad closed.'),
      ),
    )..load(); // Start loading
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(), // Standard ad request
      adLoadCallback: InterstitialAdLoadCallback(
        // Called when the ad is successfully received.
        onAdLoaded: (InterstitialAd ad) {
          debugPrint('InterstitialAd loaded.');
          // Keep a reference to the ad so you can show it later.
          _interstitialAd = ad;
          notifyListeners();
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  Referencer() {
    debugPrint('Referencer initialized, loading ad...');
    _loadInterstitialAd(); // Initiate ad loading when the model is created
  }

  // Shows the loaded interstitial ad
  void _showInterstitialAd({required VoidCallback onAdDismissed}) {
    if (_interstitialAd == null) {
      debugPrint('Warning: attempt to show interstitial before loaded.');
      // Optionally load another ad here if it's null
      _loadInterstitialAd();
      onAdDismissed();
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      // Called when the ad showed the full screen content.
      onAdShowedFullScreenContent: (InterstitialAd ad) {
        debugPrint('$ad onAdShowedFullScreenContent.');
      },
      // Called when an impression occurs on the ad.
      onAdImpression: (InterstitialAd ad) {
        debugPrint('$ad onAdImpression.');
      },
      // Called when the ad failed to show full screen content.
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        // Dispose the ad here to free resources.
        ad.dispose();
        // Optionally load another ad here
        _loadInterstitialAd();
        onAdDismissed();
      },
      // Called when the ad dismissed full screen content.
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        // Dispose the ad here to free resources.
        ad.dispose();
        // Optionally load another ad here for the next time
        _loadInterstitialAd();
        onAdDismissed();
      },
      // Called when a click is recorded for an ad.
      onAdClicked: (InterstitialAd ad) {
        debugPrint('$ad onAdClicked.');
      },
    );

    // Show the ad
    _interstitialAd!.show();

    // Nullify the ad instance after showing as it can only be shown once
    _interstitialAd = null;
  }

  @override
  void dispose() {
    // Dispose the ad when the widget is removed
    _interstitialAd?.dispose();
    _bannerAd?.dispose(); // Dispose the banner ad
    super.dispose();
  }

  void changeInfo(String x, Map filler) {
    info[x] = filler;
    notifyListeners();
  }

  void changeSocial(String x, Map filler) {
    //this won't work because it as the error
    //annot assign parameter to string
    //remember when i uploaded it and it would make indexes
    //for all the status ids
    //so i think at some point i need to enumerate
    //whenReady and += x so it will fit properly
    whenReady.add(x);
    print(whenReady);
   // socialite[x] = filler;
    notifyListeners();
    ref.child('ru/users/$saveUser/Statuses').set(whenReady);
    ref.child('ru/Statuses').update({x: filler});
  }

  void setPic(List thisthis) {
    photo = thisthis;
  }

  List returnPic() {
    return photo;
  }


  void takeout(x) {
    whenReady.remove(x);
   // socialite.remove(x);
    notifyListeners();

    ref.child('ru/users/$saveUser/Statuses').set(whenReady);
    ref.child('ru/Statuses/$x').remove();

  }
  void deleteMe() {
    ref.child('ru/users/$saveUser').remove();
  }


//this is importNT
  //and it needs to be added to production app
  //because it will mess up new users
  //CAUSE 4 CONCERN
  void openNotebook() {
    if (info["Notebook"] != null) {
      Notebook = info["Notebook"];
    }
    else {
       Notebook = {
        "Welcome":
  {
    "saved"
    : [
    [
    0, "This is your notebook! You can add to me by going to your lessons (available from the Home page) and clicking save to Notebook"
    ],
    [
      0, "Try clicking on the circle to the left of me to change my color. Don't worry about setting the text and background color, they automatically compliment each other so the text is always visible"
    ],
    [0, "Cleaning me is as simple as swiping right! Tired of seeing this tutorial? Swipe all these tiles away and when you revisit the empty topic will be gone!"
    ]
    ]
  }
  };
  info["Notebook"] = Notebook;
    }
  }

  
  void wayClear(String seekthis) {
    print(NB[seekthis]);
    if (NB[seekthis] ==
        null) {
      NB[seekthis] =
      {"saved": []};
    }


    exp = exp + 100;
    ref.child('ru/users/$saveUser/info/exp').set(exp);
  }

  void to_Notebook(seekthis, content) {
    List hold = [...NB[seekthis]["saved"]];
    print([NB]);
    hold.add([0, "$content"]);
    NB[seekthis]["saved"] = hold;
   // set_Notebook();
  }

  void changeColor(int colorkeeper, int x, String seekthis) {
    NB[seekthis]["saved"][x][0] = colorkeeper;
  }

  void clean_Notebook(String titleKey, int x) {
    NB[titleKey]["saved"].removeAt(x);
  }

  Map getallNotes() {
    return Notebook;
  }

  Map getallStati() {
    return {}; // socialite;
  }

  int getExp() {
    return exp;
  }

  String getUser() {
    return uid ?? "";
  }

  //void setUser(String uuid ) {
  //   saveUser = uuid;
  // }


  Future<void> changi() async {
    _isLoading = true;
    notifyListeners();
    final currentUser = FirebaseAuth.instance.currentUser;
    final String realUid = currentUser?.uid ?? "Guest";

  // Check if we are holding data for the wrong person
  if (saveUser != realUid) {
    print("♻️ User Switch Detected! (Old: $saveUser -> New: $realUid)");
    
    // WIPE EVERYTHING to prevent the "Snapshot" bug
    info = {}; 
    Lemx = {};
    NB = {}; 
    
    // UPDATE THE ID to the real user
    saveUser = realUid; 
  }
    ref.child('ru/users/$saveUser').get().then((snapshot) async {
    final data = Map.from(snapshot.value as Map);
    //THIS NEEDS A TRY ... CATCH AND THE FINALLY { SHOULD BE HERE
    info = data; //['info'];
    anonTag = false;
    //alessons
    try {
      Lemx = data['lemmas'];
    }
    catch (e) {
      //THIS NEEDS TO UPDATE FIREBASE
      data['lemmas'] = {0:0};
      Lemx =data['lemmas'];
    };
      //CAUSE FOR CONCERN
   // setPic(info["info"]["photo"]);
    info["info"]["photo"] = ["4", "UP"];
    //openNotebook();
    //await NB = loadNestedJsonFromFile();
    loadedData = await loadNestedJsonFromFile(uid);
      //CAUSE 4 CONCERN anontag
    if (loadedData != null) {
        NB = loadedData!;
    } else {
      NB =  {
  "Welcome":
  {
    "saved"
        : [
      [
        0, "This is your notebook! You can add to me by going to your lessons (available from the Home page) and clicking save to Notebook"
      ],
      [
        0, "Try clicking on the circle to the left of me to change my color. Don't worry about setting the text and background color, they automatically compliment each other so the text is always visible"
      ],
      [0, "Cleaning me is as simple as swiping right! Tired of seeing this tutorial? Swipe all these tiles away and when you revisit the empty topic will be gone!"
      ]
    ]
  }
};
    }
    _isLoading = false;
    if (info['info'] != null && info['info']['languages'] != null) {
      List<dynamic> rawLanguages = info['info']['languages'];
      
      // 3. Extract and enforce the strict lemmyx formatting
      rawLanguages.forEach((item) {
        final mapItem = Map<String, dynamic>.from(item as Map);
    
    Map<String, dynamic> formattedItem = {
      "display": mapItem["display"] ?? "Unknown",
      "langx": mapItem["langx"] ?? "Unknown",
      "message": mapItem["message"] ?? "",
     "attribute": mapItem["attribute"] ?? ""
    };

    // Pass the item in, and tell it NOT to save back to Firebase!
    lemmyx.clear();
    addToLemmyx(formattedItem, false);
    notifyListeners(); // Notify UI that loading has finished
  }
    );
        }
     
    }
                                               );
                                               
                                               }

  Future<void> anonSet(bool myValue) async {
  _isLoading = true;
  notifyListeners();

  try {
    // 1. Prepare the raw data structure
    final data = {
      "info": {
        "exp": 0,
        "handle": "Guest",
        "lang": "ru",
        "photo": ["4", "UP"],
      },
      // SAFETY CHECK 1: Wrap external functions like flatten()
      "lessons": [], 
      "lemmas": {1: 100},
    };

    // Try to flatten tierkeeper safely
    try {
       data["lessons"] = flatten(tierkeeper);
    } catch (e) {
       print("⚠️ Error flattening tierkeeper: $e");
       data["lessons"] = []; // Fallback to empty list
    }

    anonTag = myValue;
    info = data;

    // 2. SAFETY CHECK 2: jsonDecode is the most common crasher
    try {
      List aLessons = jsonDecode(forEducation.all);
      info["lessons"] = aLessons;
    } catch (e) {
      print("⚠️ Error decoding lessons JSON: $e");
      // Fallback: don't crash, just leave lessons as is
    }

    // 3. Handle Lemmas
    try {
      Lemx = data['lemmas'] as Map;
    } catch (e) {
      data['lemmas'] = {0: 0};
      Lemx = data['lemmas'] as Map;
    }

    // 4. Set the Notebook (This is the important part for you!)
    NB =  {
  "Welcome":
  {
    "saved"
        : [
      [
        0, "This is your notebook! You can add to me by going to your lessons (available from the Home page) and clicking save to Notebook"
      ],
      [
        0, "Try clicking on the circle to the left of me to change my color. Don't worry about setting the text and background color, they automatically compliment each other so the text is always visible"
      ],
      [0, "Cleaning me is as simple as swiping right! Tired of seeing this tutorial? Swipe all these tiles away and when you revisit the empty topic will be gone!"
      ],
          [0, "If you're using the Guest sign-in (I can tell!) your Notebook will not be available between sessions without a user account."
          ]
    ]
  }
};
  } catch (e) {
    // CATCH-ALL: If anything else above explodes, print it but don't stop the app
    print(" CRITICAL ERROR in anonSet: $e");
  } finally {
    // 5. ALWAYS FINISH
    // This 'finally' block runs no matter what.
    _isLoading = false;
    notifyListeners();
  }
}

  void sendtoLessons(List lessons) {
    ref.child('ru/users/$saveUser/lessons').set(lessons);
    info["lessons"] = lessons;
    notifyListeners();
  }

  void set_Notebook() {
    print(NB);
    if (anonTag == false) {
    saveNestedJsonToFile(NB, uid);
    }

    //check to make asure colors are updating
  }

  void addComment(String text, List pic, String postid) {
    Map socialite = {};
    try {
      if (socialite[postid]["comments"][0] == 'empty') {
        socialite[postid]["comments"][0] = text;
        //this needs to be a variable
        socialite[postid]["commentUsers"][0] = pic;
      }
      else {
        List bullshit = [...socialite[postid]["comments"]];
        bullshit.add(text);
        socialite[postid]["comments"] = bullshit;
        List extra = [...socialite[postid]["commentUsers"]];
        extra.add(pic);
        socialite[postid]["commentUsers"] = extra;

      }
      ref.child('ru/Statuses/$postid/comments').set(
          socialite[postid]["comments"]);
      ref.child('ru/Statuses/$postid/commentUsers').set(
          socialite[postid]["commentUsers"]);
    }

    catch

    (

    e

    ) {}
  }

  void novarlemmaSet(Map lemmas) {
   // ref.child('ru/users/$saveUser/lemmas').set(lemmas); //late
    Lemx = lemmas;
  }

  Map getLemma() {
    return Lemx;
  }

// 2. Create a helper method to add items and trigger the UI rebuild
  void addToLemmyx(Map newItem, bool saveToCloud) {
    lemmyx.add(newItem);
    if (saveToCloud) {
    ref.child('ru/users/$saveUser/info/languages').set(lemmyx);
  }
    notifyListeners(); 
  }


Future<void> firstTime(List pic, String handle) async {
  // 1. Get the current user directly (no listener!)
  final User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    // 2. Construct your data map exactly as before
    Map grabit = {
      "info": {
        "exp": 0, 
        "handle": handle, 
        "lang": "ru", 
        "photo": pic
      },
      "lessons": flatten(tierkeeper),
    };

    // 3. Update the database immediately
    // Using 'await' here ensures the data is saved before the app moves on
    await ref.child('ru/users').update({user.uid: grabit});
    
  } else {
    print("Error: No user found. Cannot run firstTime setup.");
  }
}
}

class LoadingWithStateMgmt extends StatelessWidget {
  final bool isLoading;
  final Widget Child; //MAKE A DEFAULT FOR THIS SO WHEN THE HOME OPENS...

   const LoadingWithStateMgmt({
     Key? key,
     required this.isLoading,
     required this.Child,
   }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // --- This is where you "Get the model instance (provided higher up)" ---
    // Providerof<MyDataModel>(context) looks UP the tree from this widget's context
    // to find the nearest MyDataModel instance provided by a Provider.
    // The 'listen: false' is important here because we only want to CALL a method (loadData)
    // and NOT rebuild this specific widget when the model changes.


    // If you wanted the widget to rebuild when _isLoading or _data changes,
    // you would either omit 'listen: false' (as listen defaults to true)
    // or use context.watch<MyDataModel>() which is the newer syntax for listening.
    // final dataModelForWatching = context.watch<MyDataModel>();

    debugPrint('StateMgmt being triggered'); // Add this log
    return Scaffold(
      appBar: AppBar(title: Text('Kangarule')),
      body: Center(
        // Use a Consumer or another Provider.of (with listen: true or context.watch)
        // if the widget *itself* needs to rebuild when the state changes.
        // In this case, we'll use a Consumer to react to isLoading changes.
        child: Consumer<Referencer>(
          builder: (context, model, child) {
            return //model.isLoading // Check the loading state from the mode ?
              Column(
                children: [
                  // Other widgets...
                  Expanded( // Or Flexible()
                    child: Image(image: AssetImage('assets/pics/movetopics.jpg')),
                  ),
                  SizedBox(
                    width: double.infinity, // Make the SizedBox take the full available width
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => Child
                            )
                        );
                      },
                      child: const Text('Continue'),
                    ),
                  ),
                  // Other widgets...
                ],
              );
          },
        ),
      )
    );
  }
}


class myIndicator extends StatelessWidget {
  myIndicator({super.key,
    required this.progress,
    required this.size
  });
  late double progress;
  late double size;
  List fake = ["You're doing it!", "Great work.", "Are you speaking yet?", "I love you.", "Keep trying!", "You can make it!", "Good job!", "Practice makes perfect!", "A lesson a day..."];
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 80.0,
      //60.0,
      lineWidth: 5.0,
      percent: progress,
      center: Text((fake..shuffle()).first),
      progressColor: Colors.green,
    );
  }
}



class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

}








const List texttileTheme = [Colors.black, Colors.blue, Colors.red, Colors.green, Colors.purple, Colors.yellow, Colors.pink, Colors.white];
const List boxTheme = [Colors.white, Colors.orange, Colors.green, Colors.red, Colors.yellow, Colors.purple, Colors.green, Colors.black ];







Iterable<List<T>> zip<T>(Iterable<Iterable<T>> iterables) sync* {
  if (iterables.isEmpty) return;
  final iterators = iterables.map((e) => e.iterator).toList(growable: false);
  while (iterators.every((e) => e.moveNext())) {
    yield iterators.map((e) => e.current).toList(growable: false);
  }
}




class ProgressIndicatorApp extends StatelessWidget {
  const ProgressIndicatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProgressIndicatorExample(),
    );
  }
}

class ProgressIndicatorExample extends StatefulWidget {
  const ProgressIndicatorExample({super.key});

  @override
  State<ProgressIndicatorExample> createState() =>
      _ProgressIndicatorExampleState();
}

class _ProgressIndicatorExampleState extends State<ProgressIndicatorExample>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const CircularProgressIndicator(
              value: .5,
              semanticsLabel: '',
            ),
          ],
        ),
      ),
    );
  }
}





class MyCard extends StatelessWidget {
  const MyCard({super.key,
    required this.handle,
    required this.exp,
   required this.useasImage,
  });
  final String handle;
  final String exp;
  final List useasImage;

  @override
  Widget build(BuildContext context) {
    return
      Container(
          color: Colors.red.withOpacity(.3),
          alignment: Alignment.center,
          child:
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child:
                ListTile(
                 leading:  _UserImage(picture: context.read<Referencer>().returnPic()),
                                title:Text(handle,
                    style: TextStyle(fontSize:
                    AdaptiveTextSize().getadaptiveTextSize(context, 16)), ),
                  subtitle: Text(exp,
                    style:TextStyle(fontSize:
                    AdaptiveTextSize().getadaptiveTextSize(context, 16)), ),
                
                )
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('Exercises'),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Sentences(sentencestart: {} )
                        )
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    const SizedBox(width: 8),
                  ],
                  //  )
                )
              ]
          )
      );
  }
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
);


//try{
//final auth = FirebaseAuth.instance;
//} catch (e) {
// ignore: avoid_print
//  await Firebase.initializeApp();
//}




SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
    .then((_) {
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider<User?>( // Ensure type is correct, User? if authStateChanges emits null
          initialData: null,
          create: (context) => context.read<AuthenticationService>().authStateChanges,
        ),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (context) {
            final referencer = Referencer();
            referencer.recoverPendingTask();
            //referencer.initializeAds(); // Assuming Referencer has this method now
            return referencer;
          },
        ),
      ],
      child: const HelloFlutterApp(), // HelloFlutterApp is now a StatelessWidget or StatefulWidget without MultiProvider in build()
    ),
  );
});
}

// HelloFlutterApp can now be a StatelessWidget since MultiProvider is gone from its build method
class HelloFlutterApp extends StatelessWidget {
  const HelloFlutterApp({super.key}); // Add const constructor

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, Referencer>( // You can keep the Consumer here
        builder: (context, ThemeProvider themeprovider, Referencer reffy, child) {
          return GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          scaffoldMessengerKey: snackbarKey,
          theme: Provider.of<ThemeProvider>(context, listen: true).currentTheme,
          //CHANGERU
          home: myForm() //MyHomePage()
          )
            // Your app's main content and routing starts here
            // Example:
            // return MaterialApp(
            //   title: 'My App',
            //   theme: themeprovider.currentTheme,
            //   home: AuthWrapper(), // Or your initial screen
            // );
          );
        }
    );
  }
}

class myForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return MyHomePage();
    }
    return SignIn();
  }
}
class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => SignInState();
}


class SignInState extends State<SignIn> {
  late final auth = FirebaseAuth.instance;
  final ButtonStyle style =
  ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20),
      backgroundColor: Colors.red);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  bool Dunn = false;
  String? _errorMessage;

  void _clearError() {
    setState(() {
      _errorMessage = null;
    });
  }


  void gateKeep(Map foo) {
    try {
      if (foo["info"]["handle"] != null) {
        Dunn = true;
      }
    }
    catch (e) {print("caught");}
  }

  //bool fool = false;

  void showSocialLoginSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Shrink to fit content
              children: [
                const Text(
                  "Sign in",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // -------------------------
                // OPTION A: GOOGLE
                // -------------------------
                
               // const SizedBox(height: 12),

                // -------------------------
                // OPTION B: APPLE (iOS Only)
                // -------------------------
                if (Platform.isIOS) 
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: SignInWithAppleButton(
                      onPressed: () async {
                        Navigator.pop(context); // Close popup
                        _handleAppleSignIn();
                      },
                    ),
                  ),

                if (Platform.isIOS) const SizedBox(height: 12),

                // -------------------------
                // CANCEL BUTTON
                // -------------------------
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 2. GOOGLE LOGIC (Paste your fixed logic here)
  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
     // _onLoginSuccess(); // Helper to redirect home
    } catch (e) {
      print("Google Error: $e");
    }
  }

  // 3. APPLE LOGIC
  Future<void> _handleAppleSignIn() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      
     final OAuthCredential credential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    // 3. ACTUAL SIGN IN
  //  await FirebaseAuth.instance.signInWithCredential(credential);
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    // 4. NOW this will work
    _onLoginSuccess(userCredential);
      
    } catch (e) {
      print("Apple Error: $e");
    }
  }

  // 4. SUCCESS HELPER
  Future<void> _onLoginSuccess(UserCredential uc) async {
    if (FirebaseAuth.instance.currentUser != null) {
      context.read<Referencer>().setUser(FirebaseAuth.instance.currentUser!.uid);
      
      if (mounted) {
        if (uc.additionalUserInfo?.isNewUser == true) {
   Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              QuizPage(
                                                  handle: "apple")
                                      ),
                                    );
} else {
  await context.read<Referencer>().changi(); 
  await Future.delayed(const Duration(seconds: 10));
  if (!mounted) return;

          // 3. Safely route to MyHomePage and destroy the login screen behind it
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyHomePage())
          );
}
      }
    }
  }


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    usernameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print("login being built");
    final localHeight =  MediaQuery.of(context).size.height;
    return  Scaffold(
        body: //StreamBuilder<User?>(
        //stream: auth.authStateChanges(),
        //builder: (context, snapshot) {
        //return
        SafeArea(
        child: Center(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                  child: TextField(
                        controller: emailController,
                        maxLength: 45,
                        maxLines: 1,
                        onSubmitted: (String value) {if(value.isNotEmpty && value != null){
                          TextInputAction.next;

                        }
                        },
                        decoration: const InputDecoration(
                          labelText: "Email",
                        ),
                  )
                      ),
                      Expanded(
                          child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Password",
                        ),
                          )
                      ),
                      Expanded(
                          child: Visibility(
                        visible : _active,
                        child: TextField(
                          maxLength: 30,
                          controller: confirmController,
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                          ),
                        ),
                          )
                      ),
                      Expanded(
                          child: Visibility(
                        visible : _active,
                        child: TextField(
                          maxLength: 45,
                          controller: usernameController,
                          decoration: InputDecoration(
                            labelText: "Choose username",
                          ),
                        ),
                          )
                      ),


                      Expanded(
                          child: ElevatedButton(
                          style: style,
                          child: Padding(
                              padding: //EdgeInsets.all(32.0),
                              EdgeInsets.all(localHeight * .007),
                              child: const Text("Create user", textScaleFactor: 1.8)
                          ),
                         onPressed: () async {
                            if (_active == false) {
                              setState(() => _active = true);
                            }
                            else {
                              if (passwordController.text.trim() ==
                                  confirmController.text.trim() &&
                                  usernameController.text.length != 0) {
                                try {
                                  UserCredential userCredential = await FirebaseAuth
                                      .instance.createUserWithEmailAndPassword(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );
                                  if (FirebaseAuth.instance.currentUser != null) {
                                      context.read<Referencer>().setUser(FirebaseAuth
                                         .instance.currentUser!.uid);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              QuizPage(
                                                  handle: usernameController.text)
                                      ),
                                    );
                                  }
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('The password provided is too weak.')));

                                  } else if (e.code == 'email-already-in-use') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("The account already exists for that email.")));

                                  }
                                }
                              }
                              else if (passwordController.text.trim() !=
                                  confirmController.text.trim() &&
                                  usernameController.text.length != 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Passwords do not match.")));
                              }
                              else if (passwordController.text.trim() ==
                                  confirmController.text.trim() &&
                                  usernameController.text.length == 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Please enter a username.")));

                              }
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //  const SnackBar(content: Text("TODO: Create user with email/password")));
                            }
                          }
                          )
                      ),

                      Expanded(
                          child: ElevatedButton(
                          style: style,
                          onPressed: () => showSocialLoginSheet(context),
                          child: Padding(
                              padding:  EdgeInsets.all(localHeight * .007),
                              child: const Text("Social Login", textScaleFactor: 2.2)),
                          )
                      ),

                      Expanded(
                          child: ElevatedButton(
                        style: style,
                        child:Padding(
                            padding:   EdgeInsets.all(localHeight * .007),
                            child: Text("Submit", textScaleFactor: 1.8)),
                        onPressed: () async {
                           // 1. Anonymous / Empty Check
  if (emailController.text.isEmpty && passwordController.text.isEmpty) {
    await context.read<Referencer>().anonSet(true);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => MyHomePage())
    );
    return; // STOP here
  }

  // 2. Real Login
  try {
    // A. Wait for Sign In (No .then, No .listen)
    final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(), 
      password: passwordController.text.trim()
    );

    // B. Check if it worked
    if (userCredential.user != null) {
      if (!mounted) return;

      final ref = context.read<Referencer>();
      ref.setUser(userCredential.user!.uid);

      // C. NOW we can safely await because we are in the main 'async' block
      await ref.changi(); 

      // D. Navigate only after changi finishes
      if (mounted) {
         Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => MyHomePage())
    );
      }
    }
  } catch (e) {
    print(e);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid login!"))
      );
    }
  }
},
                            ),
                        ),
                    ]
                )
            )
        )
        )
    );

  }
}
dynamic lessonmaker = jsonDecode(forEducation.all); 
List tierkeeper = [['nouns', 'tohave', 'canI', 'verbintro', 'pronounintro'], ['accusative', 'dative', 'instrumental', 'genitive', 'prepositional'], ['impersonalconstructions', 'posessivepronouns', 'interrogativepronouns', 'sayingand', 'demonstrativepronouns', 'relativepronouns'], ['positional', 'aspect', 'irregularaspect', 'imperatives', 'howtosayIlike'], ['dativeforobligations', 'askingquestions', 'howtosayshopping', 'reflexiveverbs', 'reflexivepronouns'], ['verbsofmotion', 'futuretense', 'pasttense', 'timephrases', 'past&futureobligations', 'sayingbeforeandafter'], ['adjectives', 'shortformadjectives', 'howtosayif', 'adverbs', 'adverbsII'], ['HaII', 'Dativeadvanced', 'wordswithnuances', 'irregularverbs', 'makingcomparisons']];

List tier = tierkeeper[0];

String assigner(grade) {
  if (grade < 500) {tier = tierkeeper[0]; return "young buck";}

  else if (grade >= 500 && grade < 1000) {tier = tierkeeper[1]; return "diamond digger";}

  else if (grade >= 1000 && grade < 1600) {tier = tierkeeper[2];  return "viber thriver";}
//this is wrong
  else if (grade >= 1600 && grade < 2100) {tier = tierkeeper[3];  return "star jar opener";}

  else if (grade >= 2100 && grade < 2700) {tier = tierkeeper[4];  return "rickshaw runner";}

  else if (grade >= 3200 && grade < 3700) {tier = tierkeeper[5];  return "teacher reacher";}

  else if (grade >= 3700 && grade < 4300) {tier = tierkeeper[6];  return "student master";}

  else if (grade >= 4300) {tier = tierkeeper[7]; return "owl slayer";}

  else {return "not found";}


}
String tierday(grade) {
  if (grade <= 5) {return "tier1";}

  else if (grade > 5 && grade <= 10) {return "tier2";}

  else if (grade > 10 && grade <= 16) {return "tier3";}

  else if (grade > 16 && grade <= 21) {return "tier4";}

  else if (grade > 21 && grade <= 26) {return "tier5";}

  else if (grade > 26 && grade <= 32) {return "tier6";}

  else if (grade > 32 && grade <= 37) {return "tier7";}

  else if (grade > 37) {return "tier8";}

  else {return "not found";}


}


class MyHomePage extends StatefulWidget {
  const MyHomePage ({
    Key? key,
  }) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  Future<String> startUp() async {
    return "Done";
  }


  void _moveState(context, where) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => where
      ),

    );
  }


  late TextEditingController dontroller;
  late double fanalexp;
 Map<String, bool> checkedLemmas = {};
 //late Map<dynamic, dynamic> lemmyx;
 late List<Map<String, String>>?  myVocabList; // = [{"english" : "fuck", "pashto" : "you"}]; //vocabx
  Map _dump = {};
  String saveuserName = "";
  List privet = [];
  Map allStati = {};
 late List icon;
 String? currentlyLoadingLemma;
 // late List aLessons;
  //CAUSE FOR CONCERN
// late List aLessons;
 //  flatten([['nouns', 'tohave', 'canI', 'verbintro', 'pronounintro'], ['accusative', 'dative', 'instrumental', 'genitive', 'prepositional'], ['impersonalconstructions', 'posessivepronouns', 'interrogativepronouns', 'sayingand', 'demonstrativepronouns', 'relativepronouns'], ['positional', 'aspect', 'irregularaspect', 'imperatives', 'howtosayIlike'], ['dativeforobligations', 'askingquestions', 'howtosayshopping', 'reflexiveverbs', 'reflexivepronouns'], ['verbsofmotion', 'futuretense', 'pasttense', 'timephrases', 'past&futureobligations', 'sayingbeforeandafter'], ['adjectives', 'shortformadjectives', 'howtosayif', 'adverbs', 'adverbsII'], ['HaII', 'Dativeadvanced', 'wordswithnuances', 'irregularverbs', 'makingcomparisons']]);
  


//List icon = context.read<Referencer>().returnPic();


  void clearText() {
    String postbount = uuid.v4() as String;
    Map grabit = {
      "comments": ["empty"],
      "commentUsers": [["empty", "empty"]],
      "info": {
        "date": DateFormat.yMMMd().format(DateTime.now()),
        "handle": "dontmatter",
        "photo": "WD" //context.read<Referencer>().returnPic()
      },
      "post": dontroller.text,
    };
    //context.read<Referencer>().changeSocial(postbount, grabit);
    dontroller.clear();
  }


  @override
  void initState()  {
    super.initState();
    //context.read<Referencer>().getReady();
    //fanalexp = assigner(context.read<Referencer>().getExp());
  //ANONBLACK
   // final aLessons = context.read<Referencer>().info["lessons"];
 //   final rawLessons = context.read<Referencer>().info["lessons"];
  //  final List aLessons = (rawLessons is List) ? rawLessons : ["test"];
    quiccfunk();
    dontroller = TextEditingController();
   WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<Referencer>().addListener(_onReferencerStateChanged);
    });
   
  }

  @override
  void dispose() {
    //I think I want to make a stream for comments
    //I ned to dispose of stream too
    dontroller.dispose();
    context.read<Referencer>().removeListener(_onReferencerStateChanged);
    super.dispose();
  }


  List Routes = [];


  void quiccfunk() {
    for (var i in tier) {
      Routes.add(HiFlutterApp(
          seeker: i, fun: lessonmaker[i]));
    }
  }

  Future<void> onLaunch() async {
    await Future(() {}); // <-- Dummy await
    // This code runs after build ...
    //use this instead of futurebuilder
  }

 Future<void> saveMyData({String? value="ru"}) async {
  // 1. Open the storage
  final prefs = await SharedPreferences.getInstance();
  
  // 2. Set the key and value. 
  // You must use the method that matches your data type:
  await prefs.setString('lang_pref', value ?? 'ru');
  

}
//changex
     Future<List<Map<String, String>>> loadVocabFromHive(String resourceName) async {
    var lessonsBox = await Hive.openBox('lessonsBox');
    dynamic savedData = lessonsBox.get(resourceName);

    if (savedData != null && savedData is Map && savedData['vocab'] != null) {
     List<dynamic> rawList = savedData["vocab"];
List<Map<String, String>> formattedVocab = [];
for (var item in rawList) {
  final mapItem = Map<dynamic, dynamic>.from(item as Map);
  
  formattedVocab.add({
    'english': mapItem['english']?.toString() ?? "",
    'target': mapItem['target']?.toString() ?? mapItem['pashto']?.toString() ?? "", 
  });
}

return formattedVocab;
     // return rawList;
     //.map((item) {
   //    final mapItem = Map<dynamic, dynamic>.from(item as Map);
      
        //return {
         // 'english': mapItem['english']?.toString() ?? "",
   //       'target': mapItem['target']?.toString() ?? "", //TOPP
   //     };
  //    }).toList();
    } 
    
    // If it doesn't exist, just hand back an empty list
    return []; 
  }

 List<String> processFetchedData(Map avedData) {  
        avedData.forEach((key, value) {
      String header = key.toString();
      if (header == 'vocab') return;
      if (value is List) {
        List<String> verbatimTexts = value.map((item) => item.toString()).toList();

        
        if (lessonmaker.containsKey(header)) {
          lessonmaker[header]!.addAll(verbatimTexts);
        } 
        else {
          lessonmaker[header] = verbatimTexts;
        }
      }
    });
  List<String> Need = avedData.keys.map((key) => key.toString()).toList();
  return Need;
  
 }
 // 1. Add BuildContext to the parameters
 //I NEED TO CHANGE RETURN TYPE IF I MOVE REFERENCER REFERENCES UP HERE
Future<List<String>> fetchSpecificResource(BuildContext context, String resourceName) async {
 //CHANGE ARGS LATER 
 //THIS IS A PLACEHOLDER ------------------------------------------------------------------------------ 2122
 //NEED TO PUT ULTIMATELANGUAGE
 final ref = context.read<Referencer>();
 List<String> specificDataYouNeed = [];
 var lessonsBox = await Hive.openBox('lessonsBox');
  if (lessonsBox.containsKey(resourceName)) {
   // WHAT HAPPENS IF NOT IN HIVE
    // We found it in Hive! 
    lessonmaker = {};

   Map<String, List<String>> groupedTopics = {};
   Map<dynamic, dynamic>? savedData = lessonsBox.get(resourceName);
   

  
 if (savedData is Map && savedData.isNotEmpty) {
        savedData.forEach((key, value) {
      String header = key.toString();
         //changex
      if (header == 'vocab') return;
      // 3. In your new JSON, the value is already a List of strings
      if (value is List) {
        
        // Convert the dynamic list into a List of strings
        List<String> verbatimTexts = value.map((item) => item.toString()).toList();

        // 4. If the Map already has this header, add all the texts to the existing list
        if (lessonmaker.containsKey(header)) {
          lessonmaker[header]!.addAll(verbatimTexts);
        } 
        // 5. If this is the very first time we've seen this header, assign the new list
        else {
          lessonmaker[header] = verbatimTexts;
        }
      }
    });
  
   // ... inside your if (savedData != null && savedData is Map) block ...

    // THIS replaces the old xopicslist.map assembly line!
    // It grabs all the keys (your headers) from the dictionary and packages them into a List.
    specificDataYouNeed = savedData.keys.map((key) => key.toString()).toList();
  

  // Safety check because opening the box took a split second
  if (!context.mounted) return []; 
  
  // Show the success message
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Completed! Loaded from device storage."),
      backgroundColor: Colors.green, 
    ),
  );

  return specificDataYouNeed; 
 }
   else {// THIS SHUD RUN CHECK STATUS
    if (!context.mounted) return []; 
  
  // Show the success message
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Data not in Hive, reaching out to server..."),
      backgroundColor: Colors.green, 
    ),
  );

   }
}
 //DONT CHANGE THIS ONE
 //NOT YET
 // I HAVE TO MAKE SURE EVERYTHING IS VARIABLE AND THE RIGHT ARGUMENTS ARE PASSED.
 Map<String, String> sourceData = ref.determineSource();
    
    // 2. Extract the variables
    String safeUser = sourceData['uid'] ?? "";
    String safeLang = sourceData['lang'] ?? "";
    String foldernamex = sourceData['foldername'] ?? "";
  final url = Uri.https(
    'buckethandx-220938151994.us-central1.run.app', 
    '/getLessons',                  
    {
      'user': safeUser,    //should be UID         
      'langx': safeLang,  
      'foldername': foldernamex
    },
  );

  // Optional: Give immediate feedback that the download started
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Fetching $resourceName...")),
  );

  try {
    final response = await http.get(url);

    // 2. CRITICAL PRECAUTION: Check if the user left the screen while we were waiting!
    if (!context.mounted) return [];

    if (response.statusCode == 200) {
     final responseData = jsonDecode(response.body);
     String lessonUrl = responseData['lesson_file'];
     String vocabUrl = responseData['vocab_file'];
     final lessonResponse = await http.get(Uri.parse(lessonUrl));
     final vocabResponse = await http.get(Uri.parse(vocabUrl));
     ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Data not in Hive, reaching out to server..."),
      backgroundColor: Colors.green, 
    ),
  );
     if (lessonResponse.statusCode != 200) {
       // This will throw the raw XML straight to your phone's SnackBar
     //  throw Exception("GCS REJECTED LESSON:\n${lessonResponse.body}");
      ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Not there yet!:/ try again in 1 hour."),
      backgroundColor: Colors.yellow, 
    ),
  );
     }
     
     if (vocabResponse.statusCode != 200) {
       // This will throw the raw XML straight to your phone's SnackBar
       throw Exception("GCS REJECTED VOCAB:\n${vocabResponse.body}");
     }
     //Map<String, dynamic> vocabData = jsonDecode(vocabResponse.body);
     //Map<String, dynamic> downloadedLessonData = jsonDecode(lessonResponse.body);
     Map<String, dynamic> downloadedLessonData = jsonDecode(utf8.decode(lessonResponse.bodyBytes));
     List<dynamic> vocabData = jsonDecode(utf8.decode(vocabResponse.bodyBytes));
     
     //---------------------------------------------------------------------------------------
     //IF THERES ANY PROBLEM CHECC THIS
   //var lessonsBox = await Hive.openBox('lessonsBox');
   //THIS NEEDS TO BE LANGUAGE AGNOSTIC
     //SHOULD I PUT SEPERATEX? CAUSE 4 CONCERN
   //await lessonsBox.put('pashto', downloadedLessonData);
     //CHANGEX
   Map<String, dynamic> masterDocument = {
    ...downloadedLessonData, // brings in "topics": [...]
    "vocab": vocabData   // brings in "pairs": [...]
  };

  // 5. Save the combined master document to Hive
  await lessonsBox.put(resourceName, masterDocument);
     //CHANGEX
   Map topicsList = downloadedLessonData;
   // 2. Create your new Map where the values are LISTS
        lessonmaker = {};
//changex grouped topics is the problem get rid of it
  //      Map<String, List<String>> groupedTopics = {};
     if (masterDocument.isNotEmpty) {
    
specificDataYouNeed = processFetchedData(masterDocument);
      }
     else {
      if (!context.mounted) return []; 
  
  // Show the success message
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Something went terribly wrong."),
      backgroundColor: Colors.red, 
    ),
  );

     }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Success! Lesson downloaded."),
          backgroundColor: Colors.green, // Visual cue for success
        ),
      );
      // ... parse your JSON and save to file ...------------------------------------------------------ 2151
     tier = downloadedLessonData.keys.take(5).toList();
     //IDK WHEN TIER WILL SHOW UPDATED WHEN HOMEPAGE IS RFRESHED
     return specificDataYouNeed;
    } 
    else if (response.statusCode == 400) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error: Missing parameters."),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
    else if (response.statusCode == 404) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Lesson '$resourceName' not found on the server."),
          backgroundColor: Colors.orange,
        ),
      );
    } 
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Server crashed: Error ${response.statusCode}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    // Check mounted again just in case the error took a while to throw
    if (!context.mounted) return [];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Failed: $e"), //Text("Network request failed. Please check your connection."),
        backgroundColor: Colors.red,
      ),
    );
  }
 return [];
}

void _onReferencerStateChanged() {
  final ref = context.read<Referencer>();
    
    if (ref.currentTaskState == PipelineState.downloading) {
      ref.currentTaskState = PipelineState.done; // Reset it immediately
      
   //   Map<String, String> sourceData = ref.determineSource();
      String dyL = ref.ULTIMATELANGUAGE;
      fetchSpecificResource(context, dyL);
}
}
 
Widget _buildStatusIcon(PipelineState currentState, PipelineState rowState) {
    // 1. Prevent the "Enum Trap" - Never show green if it's an error
    if (currentState == PipelineState.error) {
      return const Icon(Icons.error, color: Colors.red);
    }
    
    // 2. The step is successfully finished
    if (currentState.index > rowState.index) {
      return const Icon(Icons.check_circle, color: Colors.green);
    }
    
    // 3. The step is currently running
    if (currentState == rowState) {
      return const CircularProgressIndicator();
    }
    
    // 4. The step hasn't started yet
    return const Icon(Icons.radio_button_unchecked);
  }

  @override
  Widget build(BuildContext context) {


    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    List lemmyx = context.watch<Referencer>().lemmyx;
    return Scaffold(
        appBar: AppBar(
          actions: [

            IconButton(
                onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => const MyHomePage()), // Replace with your exact Home widget
  (route) => false, // The 'false' tells it to destroy every other screen in the stack
);
                },
                icon: Text(
                    '🏠', // Home emoji
                    style: TextStyle(
                      fontSize: 24, // Adjust size to look like an icon
                      color: Colors.white, // Adjust colorl
                    )
                )
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => StateMgmt(isLoading: context.watch<Referencer>()._isLoading, Child: MyNotebook())
                  ),
                );
              },
              icon: const Icon(Icons.auto_stories),
            ),
            IconButton(
              onPressed: () async {
               String RQ = (await SharedPreferences.getInstance()).getString('lang_pref') ?? 'ru';
               if (!context.mounted) return;
               if (RQ == 'ru') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Sentences(sentencestart: context.read<Referencer>().getLemma())
                )
                );
               }
               else {
                //CAUSE 4 CONCERN THIS NEEDS A VARIABLE CHANGEX
               myVocabList = await loadVocabFromHive(RQ);
               Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Sentencesx(vocabx: myVocabList) //[{"pashto": "fudge", "english"  : "you"}, {"pashto": "what", "english" : "suck"}])
                                          )
                );
               }
              },
              icon: const Icon(Icons.local_laundry_service),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => const MySettings(), // <--- Direct navigation
  ),
);
              },
              icon: const Icon(Icons.miscellaneous_services),
            ),
            IconButton(
              onPressed: () {
                context.read<ThemeProvider>().switchTheme();
              },
              icon: Icon(Icons.sunny_snowing),
              //I want to make an icon animation  on click
              //so when going to different mode
              //switches to sunny for light
            ),
          ],
        ),
        body:
        FutureBuilder(
            future: startUp(), //onLaunch(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
               final referencer = context.watch<Referencer>();
               //LOOOOOOOOOOOOOOOOOOOOOOOOOOK HERE FOR UR SOURCE
             // changexx  List aLessons = (referencer.info["lessons"] as List?) ?? ["test"];
               List rawLessons = (referencer.info["lessons"] as List?) ?? [];

                // 2. ONLY use the backup if the list is completely empty
                List aLessons = rawLessons.isEmpty ? ["test"] : rawLessons;
               //If you need aLessons to permanently change when the user does something, you have to send that new data back to your Referencer class
               //final List lemmyx =["IntroPashtx","IntroDarx", "ru"];
                final rawValue = context.read<Referencer>().getExp();
                if (rawValue == null || rawValue is! num) {
                fanalexp = 10.0;
                } else {
                fanalexp = (rawValue ?? 10.0).toDouble();
                }
               // String saveuserName = _dump["info"]?["handle"] ?? "N/A"; //_dump["info"]["handle"];
              // List icon = _dump["info"]?["photo"] ?? []; //_dump["info"]["photo"];
      String saveuserName = referencer.info["info"]?["handle"] ?? "N/A";
      List icon = referencer.info["info"]?["photo"] ?? ["1", "RU"];
                return
                  Scrollbar(
                      trackVisibility: true,
                      thumbVisibility: true,
                      thickness: 12.0,
                      child: SingleChildScrollView(
                          child: Column(
                              children: [
                               //Row(
                                //mainAxisSize: MainAxisSize.min,
                                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 // crossAxisAlignment: CrossAxisAlignment.center,
                               Wrap( 
                                  alignment: WrapAlignment.spaceBetween, 
                                  crossAxisAlignment: WrapCrossAlignment.center, 
                                  children: <Widget>[Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      //  mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                            child: Column(
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.all(
                                                        12.0),
                                                    child: myIndicator(
                                                        progress: fanalexp / 4200.0, //(context.read<Referencer>().getExp() / 4200),
                                                        size: double.infinity)
                                                  //progress:_dump["language"][saveuserLang]["users"][saveUser]["info"]["exp"] / 4400 , size: double.infinity)
                                                  ),
                                                Padding(
                                                  padding: EdgeInsets.all(12.0),
                                                  child:

                                                  Container(
                                                    height: screenHeight / 6,
                                                    width: screenWidth / 2.1,
                                                    color: Colors.white,
                                                    child:
                                                   Center(
            child: MyCard(handle: saveuserName,
                                                        exp: assigner(fanalexp.toInt()),
                                                        useasImage: [
                                                          boxTheme[1],
                                                          "ru"
                                                        ]),                       
        ),
                                                  ),

                                                  //   ]
                                                ),
                                              ],
                                            )
                                        ),
                                        //   Center() child:
                                        Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage(
                                                              alessons: aLessons)),
                                                );
                                              },
                                              child: const Text('All Lessons'),
                                            )
                                        ),
                                    
                                    Container(
                                      // alignment: Alignment.topRight,
                                      height: screenHeight / 3,
                                      width: screenWidth / 2.2,
                                      child: MyApp( //active: _active,
                                        //onChanged: _handleTapboxChanged,
                                        onSelected: (Routes) {
                                          _moveState(context, Sentences);
                                        },
                                        //(customer) { _moveState(context);

                                        //   },
                                        items: List<ListTile>.generate(
                                            tier.length,
                                                (i) =>
                                            tier[i] != null
                                                ? ListTile(title:
                                            Text('${tier[i]}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),),
                                                minVerticalPadding: 12,
                                                onTap: () {
                                                  _moveState(
                                                      context, Routes[i]);
                                                }
                                            )
                                                : ListTile(
                                                title:
                                                Text('Sender')
                                            )
                                        ),

                                      ),
                                    ),
  ]
                                  ),
//gakked out
                                                   //  Expanded(
//  child: 
                                                 //    Flexible(
                                                  //   child: 
                                                     Container(
                                       alignment: Alignment.topRight,
                                      height: screenHeight / 3,
                                      width: screenWidth / 2.2,
                                      child: ListView.builder( 
    itemCount: lemmyx.length+1, //isthisupdating WITH NEW LENGTH!? NO IDEA TILE DISAPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPEARS
    itemBuilder: (context, i) {
      if (i == lemmyx.length) {
      return ListTile(
       key: const ValueKey('upload_button_key'),
        title: const Text(
          "Upload PDF", 
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.arrow_drop_up),
        tileColor: Colors.grey[200],
        onTap: () async {
       final referencer = context.read<Referencer>();
    String documentNameToDisplay = "";
    if (referencer.currentTaskState != PipelineState.idle) {
      // SCENARIO A: A task is already running! 
      // Skip the file picker entirely and grab the active name.
      documentNameToDisplay = referencer.activeLesson ?? "PDF Document";
      
    } else {
     bool anonTine = referencer.anonTag;
     if (anonTine == true) {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Account Required"),
              content: const Text(
                "You must create a free account to upload and process PDF documents. Please log in or sign up to unlock this feature."
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Close'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                // Optional: You can add a second button here that navigates them directly to your Start/Login screen
              ],
            );
          },
        );
        
        return; // <-- CRITICAL: This stops the code here so the file picker never opens!
      }
      // SCENARIO B: We are completely idle. Open the file picker!
     bool? userAgreed = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Copyright Notice"),
                  content: const Text(
                    "By proceeding, you confirm that you own the rights to this document or have explicit permission to upload and process it. Do not upload copyrighted textbooks or strictly protected materials."
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancel', style: TextStyle(color: Colors.red)),
                      onPressed: () => Navigator.of(context).pop(false), // Returns false
                    ),
                    ElevatedButton(
                      child: const Text('I Agree'),
                      onPressed: () => Navigator.of(context).pop(true), // Returns true
                    ),
                  ],
                );
              },
            );

            // If the user tapped 'Cancel' or tapped outside the dialog, stop everything.
            if (userAgreed != true) return;
      FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'], 
      );

      // If they close the picker without selecting a file, abort everything.
      if (result == null || result.files.single.path == null) return; 

      documentNameToDisplay = result.files.single.name;
      String filePath = result.files.single.path!; 
      
      // Start the heavy API pipeline with the brand new file!
      referencer.startHeavyPipeline(filePath);
    }

    // ==========================================
    // 2. OPEN THE ALERT DIALOG 
    // (Both paths lead here!)
    // ==========================================
    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        
        return Consumer<Referencer>(
          builder: (context, ref, child) {
            
            // Auto-close the dialog when the 30-minute task finally finishes
            if (ref.currentTaskState == PipelineState.done) {
               WidgetsBinding.instance.addPostFrameCallback((_) {
                 if (Navigator.canPop(context)) Navigator.pop(context);
               });
            }

            return AlertDialog(
              title: Text('Processing $documentNameToDisplay'), 
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // UI ROW 1: Uploading
                  ListTile(
                    leading: _buildStatusIcon(ref.currentTaskState, PipelineState.approving),
                    title: const Text("PDF Uploaded"),
                  ),
                  
                  // UI ROW 2: Approving
                  ListTile(
                    leading: _buildStatusIcon(ref.currentTaskState, PipelineState.downloading),
                    title: const Text("License Approved"),
                    subtitle: ref.currentTaskState == PipelineState.approving 
                        ? const Text("This usually takes about 30 minutes...") 
                        : null,
                  ),

                  // UI ROW 3: Downloading
                  ListTile( //CAUSE 4 CONCERN I THINK MY ENUM NEEDS MORE STATES
                    leading:_buildStatusIcon(ref.currentTaskState, PipelineState.downloading),
                    title: const Text("Lessons Downloaded"),
                  ),
                ],
              ),
              actions: <Widget>[
                // KILL SWITCH
                TextButton(
                  child: const Text('Cancel Request', style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    ref.cancelPipeline(); 
                    Navigator.of(context).pop(); 
                  }, 
                ),
                
                // HIDE BUTTON
                TextButton(
                  child: const Text('Close (Run in Background)'),
                  onPressed: () {
                    Navigator.of(context).pop(); 
                  }, 
                ),
              ],
            );
          },
        );
      },
    );
  },
      );
    }
      // Handle the null "Sender" case from your original code
      if (lemmyx[i]["display"] == null) {
        return const ListTile(title: Text('Sender'));
      }

      // Now you can use CheckboxListTile freely!
      return Tooltip(
  // 1. The text you want the popup to display
  message: "${lemmyx[i]["message"]}.", 
  
  // 2. Optional: Force it to only trigger on a long-press (great for mobile)
  triggerMode: TooltipTriggerMode.longPress, 
  
  // 3. Optional: Customize how it looks
  decoration: BoxDecoration(
    color: Colors.black87,
    borderRadius: BorderRadius.circular(8),
  ),
 textStyle: const TextStyle(color: Colors.white),
       child: CheckboxListTile(
        title: Text(
          '${lemmyx[i]["display"]}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        
        // Moves the checkbox to the left side
        controlAffinity: ListTileControlAffinity.leading, 
        
        // Look up the state in your map
        value: checkedLemmas[lemmyx[i].toString()] ?? false, 
        
        onChanged: (bool? newValue) async {
          if (newValue == true) {
            
            // Wait for the user's choice from the dialog
            bool? confirmDownload = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Confirm Download'),
                  content: Text('You are about to download ${lemmyx[i]["display"]}. Are you sure?'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancel'),
                      // Returning 'false' means they canceled
                      onPressed: () => Navigator.of(context).pop(false), 
                    ),
                    TextButton(
                      child: const Text('Confirm'),
                      // Returning 'true' means we proceed
                      onPressed: () => Navigator.of(context).pop(true), 
                    ),
                  ],
                );
              },
            );

            // 2. If they tapped 'Cancel' or tapped outside the box, stop right here.
            if (confirmDownload != true) return;

            // 3. They confirmed! Now we update the UI and start the download.
            setState(() {
              
              checkedLemmas.clear();
              checkedLemmas[lemmyx[i]["display"].toString()] = true;
              currentlyLoadingLemma = lemmyx[i]["langx"].toString(); // Show hourglass
              context.read<Referencer>().setCurrentLanguage(lemmyx[i]["langx"]);
              saveMyData(value:currentlyLoadingLemma);
            });
           if (currentlyLoadingLemma == 'ru') {
            //DOES THIS NEED A SETSTATE?
            context.read<Referencer>().sendtoLessons(flatten(tierkeeper));
            lessonmaker = jsonDecode(forEducation.all); 
            //saveMyData(value:currentlyLoadingLemma);
            return;
           }
            saveMyData(value:currentlyLoadingLemma);
            //my_lang_pref = currentlyLoadingLemma;
              
            
            fetchSpecificResource(context, lemmyx[i]["langx"].toString()).then((parsedData) {
               if (context.mounted) {
                  setState(() {
                    currentlyLoadingLemma = null; // Hide hourglass
                  });
                //I NEED THE CONTEXT.READ<REFERENCER> STATEMENTS HERE OR JUST THE SETSTATE
                  context.read<Referencer>().sendtoLessons(parsedData);
                 
               }
            }).catchError((error) {
               if (context.mounted) {
                  setState(() {
                    currentlyLoadingLemma = null; // Hide hourglass on error
                  });
               }
               print("Server call failed: $error");
            });

          } else {
            // 5. If they UNCHECK the box, we don't need a popup. 
            // Just instantly clear it.
            setState(() {
              checkedLemmas.remove(lemmyx[i]["display"].toString());
              currentlyLoadingLemma = null; 
            });
            context.read<Referencer>().sendtoLessons(checkedLemmas.keys.toList());
          }
        }
        ),
      );
    },
  ),
                                                     
   ),
                                  ]
                                   
                              ),
                              ]
                          )
                      )
                  );
              }
              else {
                return Center(
                    child: Container(
                        decoration: BoxDecoration
                          (
                          color: Colors.black,
                          border: Border.all(),),
                        height:MediaQuery.of(context).size.width,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset('assets/pics/movetopics.jpg',
                            fit: BoxFit.contain)
                    )
                );
              };
            }

        )
    );
  }
}












class MyApp extends StatelessWidget {
  final List<ListTile> items;
  final Function(ListTile) onSelected;

  MyApp({super.key,
    // this.active = false,
    required this.onSelected,
    //  required this.onChanged,
    required this.items
  });




  // final bool active;
//  final ValueChanged<bool> onChanged;


  // @override
  // void initState() {
  //   super.initState();
//  }







  @override
  Widget build(BuildContext context) {
    const title = 'Agenda';

    return MaterialApp(
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.amber[100]
      ),
      debugShowCheckedModeBanner: false,
      title: title,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[900],
          title: const Text(title),
        ),
        body:
        ListView.builder(
          // Let the ListView know how many items it needs to build.
          itemCount: items.length,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            final item = items[index];

            return ListTile(
                title: item.build(context),
                //trailing: Icon(Icons.check_circle_outline_sharp),
                onTap: () {
                  final customer = this.items[index];
                  this.onSelected(customer);
                }

            );
          },

          //paranthese here
        ),
      ),
    );
  }
}



/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);


}

/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  @override
  Widget buildSubtitle(BuildContext context)
  {//was .shrink
    return SizedBox.shrink();
  }
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  @override
  Widget buildTitle(BuildContext context) => GestureDetector(
      child: Text(sender)
  );

  @override
  Widget buildSubtitle(BuildContext context) => Text(body);
}



class HomePage extends StatefulWidget {
  late List alessons;


  HomePage({super.key,
    // this.active = false,
    required this.alessons,
    //  required this.onChanged,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Generate dummy data for the list view
  //final List<String> _products =
  //List.generate(100, (index) => "Product ${index.toString()}");
  late List allLessons;
  bool used = false;
  @override
  void initState() {
    super.initState();
    // fanalexp = assigner(_dump["info"]["exp"]);
    //this needs to be fixed
    allLessons = [...widget.alessons];

  }


  @override
  Widget build(BuildContext context) {
    //List alessons = _dump["language"]["ru"]["users"][saveUser]["info"]["lessons"];
    return
      MaterialApp(
          theme: ThemeData.light().copyWith(
              scaffoldBackgroundColor: Colors.black
          ),
          debugShowCheckedModeBanner: false,
          home:
          Scaffold(
            // drawer: NavDrawer(),
            //change this out
            //ScaffoldMessenger.of(context).hideCurrentSnackBar();
              appBar: AppBar(
                title: const Text('All Lessons'),
                leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {if (used == true) {
                      context.read<Referencer>().sendtoLessons(allLessons);
                    }
                    setState(() {used = false;});
                    Navigator.of(context).pop();
                    }
                ),
              ),
              body:
              ReorderableListView.builder(
                  itemCount: allLessons.length,
                  itemBuilder: (context, index) {
                    final String productName = allLessons[index];
                    return
                      Card(
                          key:  //UniqueKey(),
                          ValueKey(productName),
                          color: Colors.amberAccent,
                          elevation: 1,
                          margin: const EdgeInsets.all(10),
                          child:
                          ListTile(
                              contentPadding: const EdgeInsets.all(15),
                              title: Text(
                                productName,
                                style: const TextStyle(fontSize: 15),
                              ),
                              trailing: const Icon(Icons.drag_handle),
                              onTap: () {try {Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>  StateMgmt(isLoading: context.watch<Referencer>()._isLoading, Child: HiFlutterApp(
                                          seeker: allLessons[index], fun: lessonmaker[allLessons[index]]))
                                  ),
                                          );
                              } catch(e) {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                          HiFlutterApp(seeker: "nouns", fun: lessonmaker["nouns"])
                                    ));
                              };
                              }
                          )
                      );
                  },
                  // The reorder function
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) {
                        newIndex = newIndex - 1;
                      }
                      final element = allLessons.removeAt(oldIndex);
                      allLessons.insert(newIndex, element);
                      used = true;
                    }
                    );
                  }
              )
          )
      );
  }
}
















class HiFlutterApp extends StatefulWidget {
  HiFlutterApp({Key? key,
    // this.active = false,
    required this.seeker,
    required this.fun
  }) : super(key: key);
  late String seeker;
  late List fun;
  @override
  _HiFlutterAppState createState() => _HiFlutterAppState();
}

class _HiFlutterAppState extends State<HiFlutterApp> {
  late String seeker;
  late List fun;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Memo',
      theme:  context.watch<ThemeProvider>().currentTheme,
      //context.read<SwitchThemeCubit>().state,
      home: MyRomePage(seeker: widget.seeker, fun: widget.fun),
      //selfid: widget.seeker),
    );
  }
}


//class MyRomePage extends StatelessWidget {
// MyRomePage({super.key,
// this.active = false,
//  required this.selfid
// });



class MyRomePage extends StatefulWidget {
  MyRomePage({Key? key,
    // this.active = false,
    required this.seeker,
    required this.fun
  }) : super(key: key);
  late String seeker;
  late List fun;
  @override
  _MyRome createState() => _MyRome();
}

class _MyRome extends State<MyRomePage> {
  late String saveUser;
  late Future<String> dum;
  late String _seeker;
  late List _fun;
  late List<Map<String, String>>?  myVocabList;

  Map _dump = {};
 // final anonMine = Provider.of<Referencer>(context, listen: false).anonTag;




   Future<List<Map<String, String>>> loadVocabFromHive(String resourceName) async {
    var lessonsBox = await Hive.openBox('lessonsBox');
    dynamic savedData = lessonsBox.get(resourceName);

    if (savedData != null && savedData is Map && savedData['vocab'] != null) {
     List<dynamic> rawList = savedData["vocab"];
List<Map<String, String>> formattedVocab = [];
for (var item in rawList) {
  final mapItem = Map<dynamic, dynamic>.from(item as Map);
  
  formattedVocab.add({
    'english': mapItem['english']?.toString() ?? "",
    'target': mapItem['target']?.toString() ?? mapItem['pashto']?.toString() ?? "", 
  });
}

return formattedVocab;
     // return rawList;
     //.map((item) {
   //    final mapItem = Map<dynamic, dynamic>.from(item as Map);
      
        //return {
         // 'english': mapItem['english']?.toString() ?? "",
   //       'target': mapItem['target']?.toString() ?? "", //TOPP
   //     };
  //    }).toList();
    } 
    
    // If it doesn't exist, just hand back an empty list
    return []; 
  }




  Map mmaker(String title) {
    Map placeholder = {"id": "", "saved": []};
    placeholder["id"] = title;
    placeholder["saved"] = [];
    //placeholder["color"] = [0];
    return placeholder;
  }



  void local_Notebook(context) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.thumb_up),
              const SizedBox(width: 20),
              const Expanded(child: Text('Sent to notebook!'),
              ),
            ],
          ),
        )

    );
  }

  @override
  void initState() {
    super.initState();
    //context.read<Referencer>().openNotebook();
    String saveUser = context.read<Referencer>().getUser();
    context.read<Referencer>().wayClear(widget.seeker);
    _fun = widget.fun;
    _seeker = widget.seeker;
  }



  @override
  //Widget build(BuildContext context) => DefaultTabController (
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future((){}),
        //Future.wait([catchtheFeeling(selfid)]),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            //Map tryme = snapshot.data;
            final fun = widget.fun;
            //final List<int> savethis = snapshot.data.toList();
            // String trythis = utf8.decode(savethis);



            return DefaultTabController(
                length: fun.length,
                child: Scaffold(
                  //  key: scaffoldKey,
                   // drawer: NavDrawer(),
                    appBar: AppBar(
                     // centerTitle: true,
                    //  title: Text('Kangarule'), macdrizzy
                      actions: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => const MyHomePage()), // Replace with your exact Home widget
  (route) => false, // The 'false' tells it to destroy every other screen in the stack
);
                            },
                            icon: Text(
                                '🏠', // Home emoji
                                style: TextStyle(
                                  fontSize: 24, // Adjust size to look like an icon
                                  color: Colors.white, // Adjust color
                                )
                            )
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => StateMgmt(isLoading: context.watch<Referencer>()._isLoading, Child: MyNotebook())
                              ),
                            );
                          },
                          icon: const Icon(Icons.auto_stories),
                        ),
                        IconButton(
              onPressed: () async {
               String RQ = (await SharedPreferences.getInstance()).getString('lang_pref') ?? 'ru';
               if (!context.mounted) return;
               if (RQ == 'ru') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Sentences(sentencestart: context.read<Referencer>().getLemma())
                )
                );
               }
               else {
                //CAUSE 4 CONCERN THIS NEEDS A VARIABLE
               myVocabList = await loadVocabFromHive(RQ);
               Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Sentencesx(vocabx: myVocabList) //[{"pashto": "fudge", "english"  : "you"}, {"pashto": "what", "english" : "suck"}])
                                          )
                );
               }
              },
              icon: const Icon(Icons.local_laundry_service),
            ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => const MySettings(), // <--- Direct navigation
  ),
);
                          },
                          icon: const Icon(Icons.miscellaneous_services),
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<ThemeProvider>().switchTheme();
                          },
                          icon: Icon(Icons.sunny_snowing),
                          //I want to make an icon animation  on click
                          //so when going to different mode
                          //switches to sunny for light
                        ),
                      ],
                      bottom: TabBar(
                        tabs: [
                          ...List<Widget>.generate(
                              fun.length,
                                  (i) => Icon(Icons.album)
                          )
                        ], //tabs
                      ), //TabBar
                    ), // Appbar

                    body: Center(
                      //on every last page I need a route to the Exercises
                      child: TabBarView(
                        //controller: _tabController,
                        children: [...List<Widget>.generate(
                          fun.length,
                              (i) =>
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [Expanded(
                                      child: Center(
                                          child: Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: SelectableText.rich(TextSpan(
                                                text: '${fun[i]} ',
                                                style:TextStyle(fontSize:
                                                AdaptiveTextSize().getadaptiveTextSize(context, 20)),
                                              )
                                              )
                                          )
                                      )
                                  ),
                                    TextButton(
                                      onPressed: () =>

                                      {
                                       // NB[_seeker]['saved'].add([0, fun[i]]),
                                        context.read<Referencer>().to_Notebook(_seeker, fun[i]),

                                        local_Notebook(context)
                                        //context)
                                      }, //  style: ButtonStyle(
                                      //backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                      //   ),
                                      child: const Text(
                                        'Send to Notebook',
                                        // style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    //  MyMessage(),
                                  ]
                              ),
                        )
                        ], // children
                      ), //TabBarView
                    ) //Center
                )
            );
          }


          else {

            return Center(
                child: Container(
                    decoration: BoxDecoration
                      (
                      color: Colors.black,
                      border: Border.all(),),
                    height:MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset('assets/pics/movetopics.jpg',
                        fit: BoxFit.contain)
                )
            );
          }
        }
    );

  }
}


//final assetsAudioPlayer = AssetsAudioPlayer();
//is having tis extra statelesswidget class unecessary?
class Sentences extends StatelessWidget {
  Sentences({
    Key? key, required this.sentencestart,
  }) : super(key: key);

  late Map sentencestart;

  @override
  Widget build(BuildContext context) {
    // return Consumer<ThemeProvider>(
    //     builder: (context, ThemeProvider themeprovider, child)
    //    {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: context.watch<ThemeProvider>().currentTheme,
      //ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      // context.read<SwitchThemeCubit>().state,
      home: Exercises(fender: sentencestart),
    );
    //     }
    //  );
  }
}


class Exercises extends StatefulWidget {

  Exercises({
    Key? key, required this.fender,
  }) : super(key: key);

  late Map fender;

  @override
  State<Exercises> createState() => _ExercisesState();
}

class _ExercisesState extends State<Exercises> {
  int _counter = 0;
  bool justonce = false;
  bool _active = false;
  //I will need to write sender to database
  Map sender = {};

  //once I get exp levels and assign exp points to all lessons
  //a switch statement should determine which pool is picked
  //then it should extra.rightpool
 List poolList = extra.phew.keys.toList();
  //late List backupPool;
  late TextEditingController _controller;
  late FocusNode myFocusNode;
  late List setTrip;
  late final AudioPlayer justaplayer;
  //late List<Map<String, String>>?  myVocabList;

  //late Future<bool> anonMine;
 // late bool anonMine;
  @override
  void initState() {
    super.initState();
    justaplayer = AudioPlayer();
    _controller = TextEditingController();
    myFocusNode = FocusNode();
    _counter = 0;
    final sender = widget.fender;
    //final anonMine = _loadData();
    if (sender.isNotEmpty) {
      setTrip = pool_cull(fast_sent_sort_for_callback());
    }
    //this is short for testing
    else if (sender.isEmpty) {setTrip = poolList.sublist(0,6);}
    //print(anonMine);
    //backupPool = [...poolList].shuffle();
    //extra.phew.keys.toList().sublist(0,6);}
    // linklink = islandreffy();
    //init should make sure it only runs once

  }

  Reference ref = FirebaseStorage.instance.ref("sounds");

//List quiccint = [16, 17, 18, 19, 20];

 
  void envelope(String question, String answer, List lemmas, String name ) {
    //i set the lemmas to answer so length should match
    //  String? name = stdin.readLineSync();
    answer = answer.trim().toLowerCase();
    name = name.trim().toLowerCase();
    if (name != null && name.isEmpty) {
      for (var z in lemmas) {
        sender.update(
          z,
              (value) => ++value,
          ifAbsent: () => 1,
        );
      }
    }
    //else if (name != null && name != lamp[k]) {
    // var user = name.split(" ");
    // var answer = lamp[k].split(" ");
    if (answer.length == 1) {
      if (name != answer) {
        sender.update(
          lemmas[0],
          //answer.toString().replaceAll(new RegExp(r"\p{P}", unicode: true), ""),
              (value) => ++value,
          ifAbsent: () => 1,
        );
      }
      else if (name == answer) {
        if (sender.containsKey(answer)) {
          sender.update(
            lemmas[0],
                (value) => --value,
            ifAbsent: () => 0,
          );
        }
      }
    }
    else if (name != null && answer.length > 1) {
      //answer means the correct answer
      //user answer is name
      final findlemma = answer.split(" ");
      final checkanswer = name.split(" ");
      Map<int, String> lap = findlemma.asMap();
      final useasIndex = lap.keys.toList();
      //what does this for loop do exactl?
      for (int i = 0; i < findlemma.length; i++) {
        //watch for if it will work on the last word
        try { if (checkanswer[i] !=  findlemma[i]) {
          sender.update(
            lemmas[i],
                (value) => ++value,
            ifAbsent: () => 1,
          );
        }
        if (checkanswer[i] == findlemma[i]) {
          //print(findlemma[i]);
          sender.update(
            lemmas[i],
                (value) => --value,
            ifAbsent: () => 0,
          );

        }

        }
        catch (e) { if (lemmas.length == findlemma.length) {
          sender.update(
            lemmas[i],
                (value) => ++value,
            ifAbsent: () => 1,
          );
        }

        }
      }
      //return sender;
    }
  }

  List pool_cull(Map sorted) {
    poolList.shuffle();
    List lilSetTrip = [];
    if (sorted.isNotEmpty) {
      context.read<Referencer>().novarlemmaSet(sorted);
      for (var x in sorted.keys.toList()) {
        if (sorted[x] < 0) {
          continue;
        }
        else {
          for (var j in poolList) {
            //this will eventually lead to a bottleneck
            //but dont worry about it now
            for (var z in extra.phew[j]['code']) {
              //if with the pool it makes it too likely
              //to pull the same sentence over and over
              //implement last= if then continue
              if (x == z) {
                lilSetTrip.add(j);
              }
            }
          }
        }
      }
    }
    else {
      lilSetTrip = poolList.sublist(0,10);
    }
    return lilSetTrip;
  }
  Map fast_sent_sort_for_callback() {
    if (sender.isNotEmpty) {
      var sorted = Map.fromEntries(
          sender.entries.toList()..sort((e2, e1) => e1.value.compareTo(e2.value)));
      return sorted;
    }
    else {return {};}

  }


  //making future a singleobj just to get started

  Future<List> islandreffy(i) async {
    List dothis = [];
    //  final sender = (await ref.child("yulnazunit1-$i.mp3").getDownloadURL())
    //     .toString();
    //  dothis.add(sender);
    return dothis; //dothis;
  }


  void openKeyboard() {
    FocusScope.of(context).requestFocus(myFocusNode);
  }


  void clearText() {
    _controller.clear();
  }


  @override
  void dispose() {
    _controller.dispose();
    myFocusNode.dispose();
    //assetsAudioPlayer.dispose();
    super.dispose();
  }



  void _handleTap() {
    //widget.onChanged(!widget.active);
    clearText();
    myFocusNode.requestFocus();
  }

  void rewind() {
    setState(() {
      setTrip = pool_cull(fast_sent_sort_for_callback());
      _counter = 0;
    });
  }
  void _handleTapboxChanged(bool newValue) {
    envelope(setTrip[_counter], extra.phew[setTrip[_counter]]["translation"],extra.phew[setTrip[_counter]]['code'], _controller.text );
    // envelope(extra.phew[setTrip[_counter]],extra.phew[setTrip[_counter]]["translation"],  extra.phew[setTrip[_counter]]['code'], _controller.text);
    setState(() {
      //submits value
      _active = newValue;
    });
  }

  void _handleRap() {
    clearText();
    //changes page
    setState(() {
      _active = false;
      _counter < setTrip.length-1 ?
      //I hope that the return from rewind
      //is included in the setstate
      //if the sentences returned get stuck thats what it is
      _counter++ : rewind();
    }

    );
    justonce = false;
    myFocusNode.requestFocus();
  }



  Future<void> onLaunch(i) async {
   // await Future(() {}); // <-- Dummy await
  final edAnonMine = Provider.of<Referencer>(context, listen: false).anonTag;
   print(edAnonMine);
   if (edAnonMine == false) {
      final mender = (await ref.child("$i.mp3").getDownloadURL()).toString();
      await justaplayer.dynamicSet(url: mender);
      justaplayer.play();
    }
  }

  //late Future linklink;



  @override
  Widget build(BuildContext context) {
    if (justonce == false) {
      onLaunch(extra.phew[setTrip[_counter]]["location"]);
      justonce = true;
    }
    //openKeyboard();
    try {
      return
        GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
             // drawer: NavDrawer(),
              appBar: AppBar(
              //  centerTitle: true,
              //  title: const Text('Kangarule'),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => const MyHomePage()), // Replace with your exact Home widget
  (route) => false, // The 'false' tells it to destroy every other screen in the stack
);
                      },
                      icon: Text(
                          '🏠', // Home emoji
                          style: TextStyle(
                            fontSize: 24, // Adjust size to look like an icon
                            color: Colors.white, // Adjust color
                          )
                      )
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => StateMgmt(isLoading: context.watch<Referencer>()._isLoading, Child: MyNotebook())
                        ),
                      );
                    },
                    icon: const Icon(Icons.auto_stories),
                  ),
                  IconButton(
              onPressed: () {},
              icon: const Icon(Icons.local_laundry_service),
            ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => const MySettings(), // <--- Direct navigation
  ),
);
                    },
                    icon: const Icon(Icons.miscellaneous_services),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<ThemeProvider>().switchTheme();
                    },
                    icon: Icon(Icons.sunny_snowing),
                    //I want to make an icon animation  on click
                    //so when going to different mode
                    //switches to sunny for light
                  ),
                ],
              ),
              body: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              decoration: BoxDecoration
                                (
                                color: Colors.black,
                                border: Border.all(),),
                              height: 100,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: GestureDetector(
                                onDoubleTap: _handleRap,
                                child: Image.asset('assets/pics/movetopics.jpg',
                                    fit: BoxFit.contain),

                              ),
                            )
                        ),
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Column(
                              children: [Row(
                                  children: <Widget>[FloatingActionButton(
                                    onPressed: () {

                                         onLaunch(extra.phew[setTrip[_counter]]["location"]);

                                    },
                                    child: const Icon(Icons.arrow_forward_sharp),
                                  ),
                                    Expanded(
                                        child: Text(
                                          setTrip[_counter],
                                          textAlign: TextAlign.center,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .headlineMedium,
                                          softWrap: true,
                                          maxLines: 3,
                                        )
                                    ),
                                  ]
                              ),

                                Visibility(
                                    visible: _active,
                                    child: Text(extra.phew[setTrip[_counter]]["translation"])
                                  //'${eng[_counter]}')
                                ),
                                Container(
                                    child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: TextField(
                                            keyboardType: TextInputType.name,
                                            autofocus: true,
                                            focusNode: myFocusNode,

                                            controller: _controller,
                                            onSubmitted: (String value) {
                                              if (value.isNotEmpty &&
                                                  value != null) {
                                                _handleTapboxChanged(true);
                                              }
                                            },
//tis
                                            //needs a safe area
                                            decoration: InputDecoration(
                                              hintStyle: const TextStyle(
                                                  color: Colors.red),
                                              hintText: "Enter your answer",
                                              filled: true,
                                              fillColor: Colors.blueAccent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius
                                                    .circular(50),

                                              ),
                                            )
                                        )
                                    )
                                )


                              ],
                            )
                        ),

                      ]
                  )
              ), //gesturedetector
            )
        );
    }

    catch(e) {
      print(e);
      return Center(
          child: Container(
              decoration: BoxDecoration
                (
                color: Colors.black,
                border: Border.all(),
              ),
              height:MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/pics/movetopics.png',
                  fit: BoxFit.contain)
          )
      );
    }
  }

}
 class Sentencesx extends StatelessWidget {
  Sentencesx({
     Key? key, required this.vocabx,
  }) : super(key: key);

  late List<Map<String, String>>? vocabx;

  @override
  Widget build(BuildContext context) {
    // return Consumer<ThemeProvider>(
    //     builder: (context, ThemeProvider themeprovider, child)
    //    {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: context.watch<ThemeProvider>().currentTheme,
      //ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      // context.read<SwitchThemeCubit>().state,
      home: Exercisesx(vocabxx: vocabx),
    );
    //     }
    //  );
  }
}


class Exercisesx extends StatefulWidget {

  Exercisesx({
       Key? key, required this.vocabxx,
  }) : super(key: key);

 
late List<Map<String, String>>? vocabxx;
  @override
  State<Exercisesx> createState() => _ExercisesxState();
}

class _ExercisesxState extends State<Exercisesx> {
  int _counter = 0;
  bool justonce = false;
  bool _active = false;
  String errormess = "No error msg saved yet.";
  List<Map<String, String>>? myVocabList;
  late TextEditingController _controller;
  late FocusNode myFocusNode;
//  List setTrip = [{"english" : "fuck", "target" : "you"}]; 
// List<Map<String, String>>  myVocabList = [{"english" : "fuck", "pashto" : "you"}];
 





 // Future<void> _fetchVocab() async {
    // 3. Grab the data from your Hive function
   //THIS NEEDS TO BE LANGUAGE AGNOSTIC
  //  var data = await loadVocabFromHive("pashto");
    
    // 4. Put the data into the variable and redraw the screen!
  //  setState(() {
   //   myVocabList = data;
  //  });
 // }
 
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    myFocusNode = FocusNode();
    _counter = 0;
   if (widget.vocabxx != null && widget.vocabxx!.isNotEmpty) {
    // If the data is completely safe and valid, use it
    myVocabList = widget.vocabxx!;
  } else {
    // If the data is missing or empty, use your backup list to prevent a crash
    myVocabList = [
      {"english": "fuck", "target": "you"}
    ];
  }
  // myVocabList = widget.vocabxx;
   //THE VARIABLE SHOULD GO HERE LANGUAGE AGNOSTIC
   //loadVocabFromHive("pashto");
  // _fetchVocab();
  

  }
 
  void openKeyboard() {
    FocusScope.of(context).requestFocus(myFocusNode);
  }


  void clearText() {
    _controller.clear();
  }


  @override
  void dispose() {
    _controller.dispose();
    myFocusNode.dispose();
    super.dispose();
  }



  void _handleTap() {
    clearText();
    myFocusNode.requestFocus();
  }

  
  void _handleTapboxChanged(bool newValue) {
   // envelope(setTrip[_counter], extra.phew[setTrip[_counter]]["translation"],extra.phew[setTrip[_counter]]['code'], _controller.text );
    // envelope(extra.phew[setTrip[_counter]],extra.phew[setTrip[_counter]]["translation"],  extra.phew[setTrip[_counter]]['code'], _controller.text);
    setState(() {
      //submits value
      _active = newValue;
    });
  }

  void _handleRap() {
   _counter++;
    clearText();
    //changes page
   setState(() {
      _active = false;
      justonce = false;
    myFocusNode.requestFocus();
  });
  }



  Future<void> onLaunch() async {
   //THIS MIHT B PROBLEM
   await Future(() {}); // <-- Dummy await
  }

 


  @override
  Widget build(BuildContext context) {
    try {
      return
        GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => const MyHomePage()), // Replace with your exact Home widget
  (route) => false, // The 'false' tells it to destroy every other screen in the stack
);
                      },
                      icon: Text(
                          '🏠', // Home emoji
                          style: TextStyle(
                            fontSize: 24, // Adjust size to look like an icon
                            color: Colors.white, // Adjust color
                          )
                      )
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => StateMgmt(isLoading: context.watch<Referencer>()._isLoading, Child: MyNotebook())
                        ),
                      );
                    },
                    icon: const Icon(Icons.auto_stories),
                  ),
                  IconButton(
              onPressed: () {},
              icon: const Icon(Icons.local_laundry_service),
            ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => const MySettings(), // <--- Direct navigation
  ),
);
                    },
                    icon: const Icon(Icons.miscellaneous_services),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<ThemeProvider>().switchTheme();
                    },
                    icon: Icon(Icons.sunny_snowing),
                  ),
                ],
              ),
              body: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              decoration: BoxDecoration
                                (
                                color: Colors.black,
                                border: Border.all(),),
                              height: 100,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: GestureDetector(
                                onDoubleTap: _handleRap,
                                child: Image.asset('assets/pics/movetopics.jpg',
                                    fit: BoxFit.contain),

                              ),
                            )
                        ),
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Column(
                              children: [Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                          myVocabList![_counter]['english'] ?? "MISSING", //Eng
                                          textAlign: TextAlign.center,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .headlineMedium,
                                          softWrap: true,
                                          maxLines: 3,
                                        )
                                    ),
                                  ]
                              ),

                                Visibility(
                                    visible: _active,
                                 //HAS RTO BE LANGUAGE AGNOSTIC
                                    child: Text(myVocabList![_counter]['target'] ?? "MISSING")
                                ),
                                Container(
                                    child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: TextField(
                                            keyboardType: TextInputType.name,
                                            autofocus: true,
                                            focusNode: myFocusNode,

                                            controller: _controller,
                                            onSubmitted: (String value) {
                                              if (value.isNotEmpty &&
                                                  value != null) {
                                                _handleTapboxChanged(true);
                                              }
                                            },
//tis
                                            //needs a safe area
                                            decoration: InputDecoration(
                                              hintStyle: const TextStyle(
                                                  color: Colors.red),
                                              hintText: "Enter your answer",
                                              filled: true,
                                              fillColor: Colors.blueAccent,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius
                                                    .circular(50),

                                              ),
                                            )
                                        )
                                    )
                                )


                              ],
                            )
                        ),

                      ]
                  )
              ), //gesturedetector
            )
        );
    }

    catch(e) {
      return Center(
          child: Container(
              decoration: BoxDecoration
                (
                color: Colors.black,
                border: Border.all(),
              ),
              height:MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/pics/movetopics.png',
                  fit: BoxFit.contain)
          )
      );
    }
  }

 
}
class BannerAdPage extends StatefulWidget {
  // Main content widget to display above the ad

  const BannerAdPage({
    Key? key
  }) : super(key: key);

  @override
  _BannerAdPageState createState() => _BannerAdPageState();
}

class _BannerAdPageState extends State<BannerAdPage> {
  // --- Future to track banner ad loading ---
  // This Future will be initialized in initState and watched by the FutureBuilder.
  late Future<BannerAd?> _bannerAdFuture;

  // Define the height of the banner ad area.
  // Using a fixed height based on the AdSize.banner size (50 logical pixels)
  // helps prevent layout shifts while the ad loads.
  static const double _bannerAdHeight = 50.0; // Standard AdSize.banner height


  @override
  void initState() {
    super.initState();
    debugPrint('_BannerAdPageState: initState called.');

    // --- Initialize the ad loading Future ---
    // Call the ad loading method and store the returned Future.
    _bannerAdFuture = _loadBannerAd();
  }

  // --- Method to load the banner ad and return a Future ---
  Future<BannerAd?> _loadBannerAd() async {
    debugPrint('_BannerAdPageState: _loadBannerAd called.');

    // Use a Completer to create a Future that will complete
    // when the ad loads successfully or fails.
    final Completer<BannerAd?> completer = Completer<BannerAd?>();

    // Get the appropriate ad unit ID based on the platform
    String adUnitId;
      //CHANGE THIS BACK LANGUAGE AGNOSTIC
      adUnitId = 'ca-app-pub-3940256099942544/2934735716'; //'ca-app-pub-5815053066312487/9845182927';



    // Create and load the BannerAd
    final bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(), // Standard ad request
      size: AdSize.banner, // Choose an appropriate size
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('_BannerAdPageState: Ad loaded.');
          // Complete the Future with the loaded ad when successful.
          completer.complete(ad as BannerAd); // Cast is safe here
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('_BannerAdPageState: Ad failed to load: $error');
          ad.dispose(); // Dispose the ad instance on failure
          // Complete the Future with null on failure.
          completer.complete(null);
          // Or completer.completeError(error); if you want FutureBuilder to show error state.
        },
        onAdOpened: (ad) => debugPrint('_BannerAdPageState: Ad opened.'),
        onAdClosed: (ad) => debugPrint('_BannerAdPageState: Ad closed.'),
        // onAdImpression: (ad) => debugPrint('_BannerAdPageState: Ad impression.'), // Optional
        // onAdClicked: (ad) => debugPrint('_BannerAdPageState: Ad clicked.'), // Optional
      ),
    );

    // Start loading the ad
    bannerAd.load();

    // Return the Future immediately. The FutureBuilder will watch this.
    return completer.future;
  }

  @override
  void dispose() {
    debugPrint('_BannerAdPageState: dispose called.');
    // Dispose of the ad instance when the widget is removed.
    // We need to access the ad instance from the completed Future's data.
    // This requires checking the Future's state or storing the ad instance
    // after the Future completes. A simpler way is to store it locally
    // or rely on the Completer's behavior if the ad is only disposed
    // on widget dispose. Let's store it locally after completion for disposal.

    // It's safer to dispose the ad instance directly here if it was stored.
    // However, since the FutureBuilder manages the AdWidget and the ad
    // instance is passed to it, and the ad instance is created and managed
    // within the _loadBannerAd method, disposing it here can be tricky
    // without storing it in a state variable.
    // A common pattern is to store the loaded ad in a state variable
    // and dispose that variable here. Let's adjust _loadBannerAd slightly
    // to return the loaded ad and store it in a state variable for disposal.

    // Re-implementing _loadBannerAd to store the ad instance for disposal:
    // (Or, simplify and just dispose the ad returned by the Future if it's available)

    // Let's stick to the FutureBuilder pattern and dispose the ad in dispose
    // if the Future has completed with data.
    _bannerAdFuture.then((ad) {
      if (ad != null) {
        debugPrint('_BannerAdPageState: Disposing loaded ad in dispose().');
        ad.dispose();
      }
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('_BannerAdPageState: build called.');

    return FutureBuilder<BannerAd?>(
              future: _bannerAdFuture, // Watch the ad loading Future initialized in initState
              builder: (context, snapshot) {
                // --- Build UI based on the ad loading snapshot's state ---
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While the ad is loading, show a small loading indicator or empty space.
                  return const SizedBox.shrink(); // Show nothing while waiting
                  // return const CircularProgressIndicator(); // Or a loading indicator
                } else if (snapshot.hasError) {
                  // If the ad failed to load with an error.
                  debugPrint('FutureBuilder (Ad): Error loading ad: ${snapshot.error}');
                  return const SizedBox.shrink(); // Show nothing on error
                  // return const Icon(Icons.error); // Or an error icon
                } else if (snapshot.hasData && snapshot.data != null) {
                  // If the Future completed successfully and has ad data, display the AdWidget.
                  final BannerAd loadedAd = snapshot.data!;
                  // Use SizedBox to ensure the AdWidget fits within the reserved height.
                  return SizedBox(
                    width: loadedAd.size.width.toDouble(),
                    height: loadedAd.size.height.toDouble(),
                    child: AdWidget(ad: loadedAd), // Display the loaded ad
                  );
                } else {
                  // If the Future completed but no ad was loaded (e.g., onAdFailedToLoad completed with null).
                  return const SizedBox.shrink(); // Show nothing if no ad data
                }
              },
    );
  }
}


//Map wholenote = _dump["language"][saveuserLang]["users"][saveUser]["Notebook"];
class MyNotebook extends StatelessWidget {
  const MyNotebook({super.key});


  @override
  Widget build(BuildContext context) {
    //return Consumer<ThemeProvider>(
    //   builder: (context, ThemeProvider themeprovider, child)
    //   {
    return MaterialApp(
      title: "Notebook",
      debugShowCheckedModeBanner: false,
      // navigatorObservers: [routeObserver],
      // routes: {
      //   'pageone': (context) => RouteAware('pageone', child: MyHomePage()),
      //   'pagetwo': (context) =>  RouteAware('pagetwo', child: Sentences()),
      //   'pagethree': (context) => RouteAware('pagethree', child: MyStatus()),

      //   },
      theme: context.watch<ThemeProvider>().currentTheme,
      //ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      //context.read<SwitchThemeCubit>().state,
      home: MyNotebookState(),
    );
  }
//  }
}

class MyNotebookState extends StatefulWidget {
  const MyNotebookState({super.key});

  @override
  State<MyNotebookState> createState() => _MyNotebookState();
}

class _MyNotebookState extends State<MyNotebookState> {
  bool _customTileExpanded = false;
  Map exposee = {};
  List quiccfix = [];
  Map _dump = {};
  //Map wholenote = {};
  bool _isAdLoaded = false;
  // We might not even need to store the ad instance locally if Referencer holds it,
  // but keeping it local allows setState to rebuild just this part.
  BannerAd? _localBannerAd;
  late List<Map<String, String>>?  myVocabList;


     Future<List<Map<String, String>>> loadVocabFromHive(String resourceName) async {
    var lessonsBox = await Hive.openBox('lessonsBox');
    dynamic savedData = lessonsBox.get(resourceName);

    if (savedData != null && savedData is Map && savedData['vocab'] != null) {
     List<dynamic> rawList = savedData["vocab"];
List<Map<String, String>> formattedVocab = [];
for (var item in rawList) {
  final mapItem = Map<dynamic, dynamic>.from(item as Map);
  
  formattedVocab.add({
    'english': mapItem['english']?.toString() ?? "",
    'target': mapItem['target']?.toString() ?? mapItem['pashto']?.toString() ?? "", 
  });
}

return formattedVocab;
     // return rawList;
     //.map((item) {
   //    final mapItem = Map<dynamic, dynamic>.from(item as Map);
      
        //return {
         // 'english': mapItem['english']?.toString() ?? "",
   //       'target': mapItem['target']?.toString() ?? "", //TOPP
   //     };
  //    }).toList();
    } 
    
    // If it doesn't exist, just hand back an empty list
    return []; 
  }
 
  void getDat(Map wholenote) {
    quiccfix.clear(); // Empties the list []
    exposee.clear();  // Empties the map {}
    for (var i in wholenote.keys) {
      //this makes the num 0 and the title 1
      if (wholenote[i]["saved"].isEmpty) {
        continue;
      }
      quiccfix.add(i);
      //output: [1, "intro"]
      exposee[i] = wholenote[i]["saved"];
      //output: {"intro": [[ck, note]]}
    }
  }

  @override
  void initState() {
    super.initState();
   // _initData();

  }
  Future<void> _initData() async {
    //BIG QUESTION DO i NEED A DOUBLE CHECK ANYMORE?
    // 1. Load the data
    final anonMine = Provider.of<Referencer>(context, listen: false).anonTag;
    if (anonMine == false) {
    NB =  {
  "Welcome":
  {
    "saved"
        : [
      [
        0, "This is your notebook! You can add to me by going to your lessons (available from the Home page) and clicking save to Notebook"
      ],
      [
        0, "Try clicking on the circle to the left of me to change my color. Don't worry about setting the text and background color, they automatically compliment each other so the text is always visible"
      ],
      [0, "Cleaning me is as simple as swiping right! Tired of seeing this tutorial? Swipe all these tiles away and when you revisit the empty topic will be gone!"
      ]
    ]
  }
};
    }
  
  }
  // List bender = sender.keys.toList();
  // List lender = sender.values.toList();
  //List<ExpansionTile> fiddle =
  //  List<Widget>.generate(bender.length, (i) => ExpansionTile)
//static List<String> fender =
  //   List.generate(lender.length, (index) => "${lender[index].toString()}");


  @override
  Widget build(BuildContext context) {
    getDat(NB);
    final referencer = Provider.of<Referencer>(context);
    //getDat(context.read<Referencer>().getallNotes());
    //wholenote = _dump["Notebook"];
    return Scaffold(
        //drawer: NavDrawer(),
        appBar: AppBar(
         // centerTitle: true,
       //   title: const Text('Kangarule'),


          actions: [
            IconButton(
            onPressed: () {
    Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => const MyHomePage()), // Replace with your exact Home widget
  (route) => false, // The 'false' tells it to destroy every other screen in the stack
);
    },
        icon: Text(
            '🏠', // Home emoji
            style: TextStyle(
              fontSize: 24, // Adjust size to look like an icon
              color: Colors.white, // Adjust color
            )
        )
    ),
    IconButton(
    onPressed: () {
    Navigator.of(context).push(
    MaterialPageRoute(
    builder: (context) => StateMgmt(isLoading: context.watch<Referencer>()._isLoading, Child: MyNotebook())
    ),
    );
    },
    icon: const Icon(Icons.auto_stories),
    ),
    IconButton(
              onPressed: () async {
               String RQ = (await SharedPreferences.getInstance()).getString('lang_pref') ?? 'ru';
               if (!context.mounted) return;
               if (RQ == 'ru') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Sentences(sentencestart: context.read<Referencer>().getLemma())
                )
                );
               }
               else {
                //CAUSE 4 CONCERN THIS NEEDS A VARIABLE
               myVocabList = await loadVocabFromHive(RQ);
               Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Sentencesx(vocabx: myVocabList) //[{"pashto": "fudge", "english"  : "you"}, {"pashto": "what", "english" : "suck"}])
                                          )
                );
               }
              },
              icon: const Icon(Icons.local_laundry_service),
            ),
    IconButton(
    onPressed: () {
    Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => const MySettings(), // <--- Direct navigation
  ),
);
    },
    icon: const Icon(Icons.miscellaneous_services),
    ),
    ],
        ),
        body: SingleChildScrollView(
            child: Column(
                children: [...List<Widget>.generate(
                    quiccfix.length,
                    //exposee.length,
                        (i) =>
                        ExpansionTile(
                            title: Text(quiccfix[i]),
                            children: [Column(
                                children: [ ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics: const ClampingScrollPhysics(),
                                    itemCount: exposee[quiccfix[i]].length,
                                    itemBuilder: (BuildContext context,
                                        int index) {
                                      return
                                        Dismissible(
                                            key: Key(exposee[quiccfix[i]][index][1]),
                                            onDismissed: (direction) {
                                              // Remove the item from the data source.
                                              context.read<Referencer>().clean_Notebook(quiccfix[i], index);

                                            },
                                            //background: Container(color: Colors.red),
                                            // allStati[x]["date"]
                                            //have you made the datemake function yet
                                            //and sorted all statuses based on date?
                                            //and added newest status to top of post?
                                            child:
                                            Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: _SingleNote(
                                                  //int.parse
                                                  colorKeeper: exposee[quiccfix[i]][index][0],
                                                  saying: exposee[quiccfix[i]][index][1],
                                                  counter: [index, quiccfix[i]],
                                                )


                                            )
                                        );
                                    }

                                  //text: '${sender[bender[i]]} ',

                                ),



                                ]
                            )
                            ]
                        )
                ),
                  Align(
                    alignment: Alignment.bottomCenter,
                          child: BannerAdPage()

                  ),
                ]
            )
        ),



    );

  }
}


class _SingleNote extends StatefulWidget {
  late String saying;
  late int colorKeeper;
  late List counter;


  _SingleNote({Key? key, required this.colorKeeper, required this.saying, required this.counter}) : super(key: key);


  @override
  EveryNoteState createState() => EveryNoteState();
}

class EveryNoteState extends State<_SingleNote> {
  // static List texttileTheme = [Colors.black, Colors.blue, Colors.red, Colors.green, Colors.purple, Colors.yellow, Colors.pink, Colors.white];
  // static List boxTheme = [Colors.white, Colors.orange, Colors.green, Colors.red, Colors.yellow, Colors.purple, Colors.green, Colors.black ];
  late String _saying;
  late int _colorKeeper;
  late int counter;
  late String title;
  @override
  void initState() {
    super.initState();
    _saying = widget.saying;
    _colorKeeper = widget.colorKeeper;
    counter = widget.counter[0];
    title = widget.counter[1];
  }
  void SwitchThisTheme() {if (_colorKeeper != 6) {
    setState(() {
      _colorKeeper++;
    }
    );
    context.read<Referencer>().changeColor(_colorKeeper, counter, title);
    //wholenote[counter[1]]["saved"][counter[0]][0] = _colorKeeper.toString();
    //write to db
  }
  else if (_colorKeeper == 6) {
    setState(() {
      _colorKeeper = 0;
      //write to db
    }
    );
    context.read<Referencer>().changeColor(_colorKeeper, counter, title );
    // wholenote[counter[1]]["saved"][counter[0]][0] = _colorKeeper.toString();
    //wholenote[counter[1]]["saved"][counter[0]][0];
  }
  }
  @override
  Widget build(BuildContext context) {
    //final CommentModel commentData =
    // InheritedPostModel.of(context).postData.comments[index];
//can I change this to a listtile instead of a container?
    return
      //Expanded(
      // flex: 3,
      //width: double.infinity,
      // height: 110,
      // margin: const EdgeInsets.symmetric(vertical: 8.0),
      // child:
      Row(children: [FloatingActionButton.small(
        onPressed: () {SwitchThisTheme();},
        //child: Icon(Icons.add,),
        //foregroundColor: texttileTheme[colorKeeper+1],
        backgroundColor: texttileTheme[_colorKeeper+1],
        //mini: true,

      ),

        Expanded(child: ColoredBox(color: boxTheme[_colorKeeper],
            child: RichText(textAlign: TextAlign.center,
                text: TextSpan(
                    text:
                    _saying,
                    style: TextStyle(color: texttileTheme[_colorKeeper], fontSize: 18)
                )
            )
        )
        ),
      ]

        //  commentData.comment,
        // key: ValueKey("${CommentsListKeyPrefix.commentText} $index"),
        // textAlign: TextAlign.left,

        //  Divider(
        //   key: ValueKey("${CommentsListKeyPrefix.commentDivider} $index"),
        //   color: Colors.black45,
        //   ),



      );
  }
}



class PostCard extends StatelessWidget {
  late Map status;
  //comments will be dissected from status
  //date and icon will be dissected from status here too
  //sould I do the parsing here and send a map to Postcard?
  //late List useasAssetImage;
  late String postid;
  // late String date;
  PostCard({Key? key, required this.status, required this.postid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      //AspectRatio(
      //aspectRatio: 2.0,
      //6 / 3,
      //  child: Card(
      // elevation: 4,
      // child:
      Container(
        width: double.infinity,
        height: 300,
        //  margin: const EdgeInsets.all(4.0),
        // padding: const EdgeInsets.all(4.0),
        child: Column(
          children: <Widget>[
            //_PostDetails(useasAssetImage: ["1", "WD"],date: "30 April 2019"),
            _PostDetails(useasAssetImage: status["info"]["photo"], date: status["info"]["date"]),
            Divider(color: Colors.grey),
            _PostTitleAndSummary(summary: status["post"]),
            //_Post(input: status),
            Divider(color: Colors.grey),
            Expanded(child: Comments(bomments: status["comments"], commentUsers: status["commentUsers"], postid: postid)) ,
          ],
        ),
        //   ),
        //   ),
      );
  }
}



class _PostTitleAndSummary extends StatelessWidget {
  late String summary;
  _PostTitleAndSummary({Key? key, required this.summary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle? summaryTheme = Theme.of(context).textTheme.headlineSmall;



    return
      // Expanded(
      // flex: 2,
      // child:
      Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //Text(title, style: titleTheme),
            //SizedBox(height: 2.0),
            Expanded(child: Text(summary, style: summaryTheme)),
          ],

        ),
      );
  }
}


class _PostDetails extends StatelessWidget {
  late List useasAssetImage;
  late String date;
  //const _PostDetails({Key? key}) : super(key: key);
  _PostDetails({Key? key, required this.useasAssetImage, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment : MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _UserImage(picture: useasAssetImage),
        //_UserNameAndEmail(),
        Spacer(flex: 1),
        Expanded(
          flex: 2,
          child: Text(date, style: Theme.of(context).textTheme.labelMedium),
        )
      ],
    );
  }
}
class Comments extends StatefulWidget {
  // late List tagz;
  //del;ete thois
  //don't verlook
  //this is fake
  //delete
  late List bomments;
  late List commentUsers;
  late String postid;
  Comments({Key? key, required this.commentUsers, required this.bomments, required this.postid}) : super(key: key);


  @override
  State<Comments> createState() => _CommentsState();
//useasAssetImage: useasAssetImage);
}

class _CommentsState extends State<Comments> {
  // late String useasAssetImage;
  late String _postid;
  late List userPic;
  // _CommentsState({Key? key, required this.useasAssetImage}) : super(key: key);
  late TextEditingController bontroller;
  late List _commentUsers;
  late List localStati;
  late final ValueNotifier<int> _counter =  ValueNotifier<int>(localStati.length);
  //ValueNotifier<int>(_tagz.length);

  void clearText() {
    String text = bontroller.text;
    setState(() {

      if (localStati[0] == 'empty')
      {localStati[0] = text;
      //this needs to be a variable
      _commentUsers[0] = userPic;
      }
      else {
        localStati.add(text);
        //don't parse colorFinder here add it as a string
        //this needs to be a user based variable
        _commentUsers.add(userPic);
      }

      bontroller.clear();
    }
    );
    context.read<Referencer>().addComment(text, userPic, widget.postid );

    //needs text, userpic, and postid

  }
  @override
  void initState() {
    super.initState();
    bontroller = TextEditingController();
    userPic = context.read<Referencer>().returnPic();
    _postid = widget.postid;
    localStati = [...widget.bomments];
    _commentUsers = [...widget.commentUsers];
  }


  @override
  void dispose() {
    super.dispose();
    bontroller.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _counter,
        builder: (BuildContext context, int _counter, Widget? child)
        {
          return
            ListView(
                children: <Widget>[TextField(
                    keyboardType: TextInputType.name,

                    controller: bontroller,
                    onSubmitted: (String value) {
                      if (value.isNotEmpty && value != null) {
                        clearText();
                      }
                    },


                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.red),
                      hintText: "Comment here",
                      filled: true,
                      fillColor: Colors.blueAccent,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: double.infinity),

                      ),
                    )
                ),
                  ...List<Widget>.generate(
                      1,
                          (i) =>
                          ExpansionTile(
                              title: const Text("See comments"),
                              initiallyExpanded: true,
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: localStati.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    //dont parse here
                                    //cause the num will be a string from rtdb
                                    //ill parse in the imagewidget
                                    //[boxTheme[int.parse(_commentUsers[index][0])], _commentUsers[index][1]]
                                    if (localStati[0] == 'empty') {
                                      return const ListTile();
                                    }
                                    else {
                                      return _SingleComment(
                                          saying: localStati[index],
                                          useasAssetImage: [
                                            _commentUsers[index][0],
                                            _commentUsers[index][1]
                                          ]);
                                    }
                                  },

                                )

                              ]
                          )
                  )

                ]
            );
        }
    );


  }
}

class _SingleComment extends StatelessWidget {
  final String saying;
  late List useasAssetImage;


  _SingleComment({Key? key, required this.saying, required this.useasAssetImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return
      ListTile(
        leading: _UserImage(picture: useasAssetImage,
        ),
        title: RichText(textAlign: TextAlign.center,
            text: TextSpan(
                text:
                saying,
                style: const TextStyle(color: Colors.black, fontSize: 18))
          //  commentData.comment,
          // key: ValueKey("${CommentsListKeyPrefix.commentText} $index"),
          // textAlign: TextAlign.left,
        ),
        //  Divider(
        //   key: ValueKey("${CommentsListKeyPrefix.commentDivider} $index"),
        //   color: Colors.black45,
        //   ),



      );
  }
}




class _UserImage extends StatelessWidget {
  late List picture;
  _UserImage({Key? key, required this.picture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      CircleAvatar(
        radius: 18,

        backgroundColor: boxTheme[int.parse(picture[0])],
        //picture as ImageProvider
        child: Text(
            picture[1]
        ),
      );
    //  );

  }
}

class MySettings extends StatefulWidget {

  const MySettings({
    Key? key,
  }) : super(key: key);

  @override
  State<MySettings> createState() => _MySettings();
}

class _MySettings extends State<MySettings> {
 late List<Map<String, String>>?  myVocabList;

  bool isOnlyWelcome = NB.length == 1 && NB.containsKey("Welcome");
  @override
  void initState() {
    super.initState();
  }

  Future<List<Map<String, String>>> loadVocabFromHive(String resourceName) async {
    var lessonsBox = await Hive.openBox('lessonsBox');
    dynamic savedData = lessonsBox.get(resourceName);

    if (savedData != null && savedData is Map && savedData['vocab'] != null) {
     List<dynamic> rawList = savedData["vocab"];
List<Map<String, String>> formattedVocab = [];
for (var item in rawList) {
  final mapItem = Map<dynamic, dynamic>.from(item as Map);
  
  formattedVocab.add({
    'english': mapItem['english']?.toString() ?? "",
    'target': mapItem['target']?.toString() ?? "", 
  });
}

return formattedVocab;
     // return rawList;
     //.map((item) {
   //    final mapItem = Map<dynamic, dynamic>.from(item as Map);
      
        //return {
         // 'english': mapItem['english']?.toString() ?? "",
   //       'target': mapItem['target']?.toString() ?? "", //TOPP
   //     };
  //    }).toList();
    } 
    
    // If it doesn't exist, just hand back an empty list
    return []; 
  }

 void _showLibrariesPopup(BuildContext context) {
  // Grab the current list of libraries from your state manager
  final libraries = context.read<Referencer>().lemmyx;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("My Libraries"),
        // SizedBox with double.maxFinite is required to keep ListView from crashing inside a dialog
        content: SizedBox(
          width: double.maxFinite, 
          child: ListView.builder(
            shrinkWrap: true, // Forces the list to only take up as much space as it needs
            itemCount: libraries.length,
            itemBuilder: (context, index) {
              final lib = libraries[index];
              
              return ListTile(
                title: Text(lib["display"] ?? "Unknown Library"),
                subtitle: Text(lib["attribute"] ?? ""),
                // NO onTap property here = no clicking, no highlighting!
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Closes the popup
            child: const Text("Close"),
          ),
        ],
      );
    },
  );
}
 
  void _showPrivacyPolicy(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Privacy Policy"),
        content: SingleChildScrollView(
          // scrollDirection defaults to vertical, which is what we want
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(ppLong,
                style: TextStyle(fontSize: 14), // Adjust font size as needed
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Closes the dialog
            },
            child: const Text("Close"),
          ),
        ],
      );
    },
  );
}

  Future<void> _showDeleteConfirmation(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap a button to close
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Account'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Are you sure you want to delete your account?'),
              SizedBox(height: 10),
              Text(
                'This action is permanent and cannot be undone.',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          // CANCEL BUTTON
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); // Just close the dialog
            },
          ),
          // DELETE BUTTON
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser; // Get the current user

    if (user != null) {
      try {
        // --- Call your Referencer method first if needed ---
        // If deleteMe() needs to run BEFORE Firebase deletion
        context.read<Referencer>().deleteMe(); // Call your method

        // --- Then delete the Firebase user ---
        await user.delete(); // Await the asynchronous deletion

        // Account successfully deleted
        debugPrint('User account deleted.');
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SignIn())
        );

                } on FirebaseAuthException catch (e) {
                  debugPrint('Error deleting user: ${e.code}');
                  
                  // Handle "Recent Login Required" error (common for deletions)
                  if (e.code == 'requires-recent-login') {
                     if (context.mounted) {
                       _showErrorDialog(context, "Security Alert", "For security, please sign out and sign in again before deleting your account.");
                     }
                  } else {
                     if (context.mounted) {
                       _showErrorDialog(context, "Error", "Could not delete account. ${e.message}");
                     }
                  }
                }
              }
            },
          ),
        ],
      );
    },
  );
}

  void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss the dialog
                },
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
         // title: const Text("Kangarule"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => const MyHomePage()), // Replace with your exact Home widget
  (route) => false, // The 'false' tells it to destroy every other screen in the stack
);
                },
                icon: Text(
                    '🏠', // Home emoji
                    style: TextStyle(
                      fontSize: 24, // Adjust size to look like an icon
                      color: Colors.white, // Adjust color
                    )
                )
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => StateMgmt(isLoading: context.watch<Referencer>()._isLoading, Child: MyNotebook())
                  ),
                );
              },
              icon: const Icon(Icons.auto_stories),
            ),
            IconButton(
              onPressed: () async {
               String RQ = (await SharedPreferences.getInstance()).getString('lang_pref') ?? 'ru';
               if (!context.mounted) return;
               if (RQ == 'ru') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Sentences(sentencestart: context.read<Referencer>().getLemma())
                )
                );
               }
               else {
                //CAUSE 4 CONCERN THIS NEEDS A VARIABLE
                try
                {
               myVocabList = await loadVocabFromHive(RQ);
                if (!context.mounted) return;
               Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Sentencesx(vocabx: myVocabList) //[{"pashto": "fudge", "english"  : "you"}, {"pashto": "what", "english" : "suck"}])
                                          )
                );
                } catch (e) {
               ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Failed to load vocabulary: $e"),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
      ),
    );
                }
               }
              },
              icon: const Icon(Icons.local_laundry_service),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => const MySettings(), // <--- Direct navigation
  ),
);
              },
              icon: const Icon(Icons.miscellaneous_services),
            ),
            IconButton(
              onPressed: () {
                //setanon
                context.read<ThemeProvider>().switchTheme();
              },
              icon: Icon(Icons.sunny_snowing),
              //I want to make an icon animation  on click
              //so when going to different mode
              //switches to sunny for light
            ),
          ],
        ),

        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: () {
    _showPrivacyPolicy(context);
  },
                      child: Text('Privacy Policy',
                                       style: Theme.of(context).textTheme.labelLarge)
                  ),
                 OutlinedButton(
                      onPressed: () {
                       showDialog(
  context: context,
  // Setting barrierDismissible to true lets them close it by tapping anywhere outside the box
  barrierDismissible: true, 
  builder: (BuildContext context) {
    return const TermsOfUseDialog(
      requireAgreement: false, 
      // You don't need to pass 'onAgreed' at all here!
    );
  }
);
            
  },
                      child: Text('Terms of Use',
                                       style: Theme.of(context).textTheme.labelLarge)
                  ),
                 ElevatedButton(
  onPressed: () {
   _showLibrariesPopup(context);
   },
  child: const Text("View Libraries"),
),
    OutlinedButton(
            child: Text('Sign Out',
                             style: Theme.of(context).textTheme.labelLarge),
    onPressed:   ()
            async {


        context.read<Referencer>().set_Notebook();// lemmas?
    //NB
            
              final anonMine = Provider.of<Referencer>(context, listen: false).anonTag;
            //  if (anonMine == false) {
              //  await FirebaseAuth.instance.signOut();
            //  }
            //  else {
                Provider.of<Referencer>(context, listen: false).anonSet(true);
                await FirebaseAuth.instance.signOut();

            //  }
        {
         //NO MOUNTED CHECK?
         Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => SignIn()),
  (Route<dynamic> route) => false, // Returning false strips away all previous screens
);
        }
        // context.read<AuthenticationService>().signOut();
        }
          // await _firebaseAuth.signOut();

    // Elevation (shadow)
    ),
                  

                  OutlinedButton(
                      onPressed: () {
    _showReportDialog(context);
  },
                      child: Text('Report a problem.',
                                       style: Theme.of(context).textTheme.labelLarge)
                  ),
                  OutlinedButton(
                    onPressed: () async {
  _showDeleteConfirmation(context);
                    },
                    child: Text('Delete account.',
                                     style: Theme.of(context).textTheme.labelLarge),
                  ),

                ]
            )
        )
    );
  }
}

class Answers extends StatelessWidget {
  final String yourAnswer; //Answer text
  //Function that is call upon when this
  //specific answer object is tapped upon.
  final Function answerQuestion;
  Answers(this.yourAnswer, this.answerQuestion);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        //Answer will be displayed as a button rather than
        //simple text, to allow for interactivity.
        child: ListTile(leading: const Icon(Icons.circle_outlined),
          title: Text(yourAnswer,
            style: const TextStyle(fontWeight: FontWeight.bold,
                fontSize: 20),),
          minVerticalPadding: 12,
          onTap: () => answerQuestion(yourAnswer),
        )
    );

  }
}

class Questions extends StatelessWidget {
  final String handler; //Question text
  Questions(this.handler);  //Class constructor
  @override
  Widget build(BuildContext context) {
    return Text(
      handler,
      style: const TextStyle( //Question text styling
        color: Colors.black,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class QuizPage extends StatelessWidget {
  late String handle;
  QuizPage({super.key, required this.handle});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(handle: handle),
    );
  }
}

class FirstPage extends StatefulWidget {
  late String handle;
  FirstPage({super.key, required this.handle});
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int _questionIndex = 0;
  //Declaring variables to store previous answers
  List traits = [];
 // List<Map<String, Object>> langoptions = [];
    List<Map<String,Object>> _questions = [
    //A list of dictionaries which represent the question, possible answers
    //and the correct answer.
   //CAUSE FOR CONCERN NEEDS TEXTBOX HERE NOW
    {
      'questionText': 'What language are you learning?',
      'answers': [],
    },
    {
      'questionText': 'What\'s the best part of speaking a different language?',
      'answers': ['to have conversations', 'to read', 'it\'s a necessity for me'],
    },
    {
      'questionText': 'What is hardest about learning a new language?',
      'answers': ['pronounciation', 'learning new phrases', 'putting sentences together', 'grammar'],

    },
  ];
  // A flag to ensure we only build the questions once
  bool _isInitialized = false;

  // 2. Use didChangeDependencies to safely grab Provider data before the screen draws
  @override
  void didChangeDependenciesx() {
   // super.didChangeDependencies();
    
    // We only want to build the list the very first time the screen loads
    if (!_isInitialized) {
      final lemmyx = context.read<Referencer>().lemmyx;
      //List<String> languageOptions = [];
      
      for (var lib in lemmyx) {
     //   _questions[0]["answers"].add(lib['display']?.toString() ?? "Unknown Language");
       (_questions[0]["answers"] as List<String>).add(lib['display']?.toString() ?? "Unknown Language");
      }
     _isInitialized = true; // Lock it so it doesn't rebuild if the keyboard pops up
    }
  }

  //Defining the function for tapping on a any specific answer.
  void _answerQuestion(String myAns) {
    // NEW: Only do the Firebase lookup when answering the question at index 1
    if (_questionIndex == 0) {
      final lemmo = context.read<Referencer>().lemmyx;
      for (var lib in lemmo) {
        if (lib['display']?.toString() == myAns) {
          // Replace ULTIMATELANGUAGE with your actual setter/variable
          context.read<Referencer>().ULTIMATELANGUAGE = lib['langx']?.toString() ?? "ru";
          break; 
        }
      }
    }

    // YOUR ORIGINAL CODE (Completely untouched)
    setState(() {
      traits.add(myAns);
      if (_questionIndex == _questions.length - 1) {
        {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Start(handle: widget.handle)
          )
          );
        }
      } else {
        _questionIndex = _questionIndex + 1;
      }
    });
  }



 

  @override
  Widget build(BuildContext context) {
   didChangeDependenciesx();
    return Scaffold(
      appBar: AppBar(
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(
          20.0,
        ),
        margin: const EdgeInsets.all(
          10.0,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Questions(
                  //This displays the current question tracked by
                  //the _questionIndex variable.
                  _questions[_questionIndex]['questionText'].toString(),
                ),
                //This displays the current questionanswers set tracked by
                //the _questionIndex variable. The spread operator helps in
                //extracting all answers without the need to write this
                //code 4 times.
                ...(_questions[_questionIndex]['answers'] as List<String>).map((answer) {
                  return Answers(answer, _answerQuestion);
                }).toList(),
                const SizedBox(
                  height: 10.0,
                ),
                //If this was the user's first attempt then any
                //empty container is displayed.


              ],
            ),
          ),
        ),
      ),
    );
  }
}


class Start extends StatefulWidget {
  final String handle;

  const Start({super.key, required this.handle});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  
  @override
  void initState() {
    super.initState();
    // This runs EXACTLY ONE TIME when the widget is first loaded.
    // It will not run again on rebuilds.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<Referencer>().firstTime(
        ["4", widget.handle.substring(2)], 
        widget.handle
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // build is now safe! It only draws UI.
    return MaterialApp(
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.black),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              
              if (mounted) {
                // DESTROY this widget so it can't run again
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => SignIn()),
                  (Route<dynamic> route) => false, // This removes all history
                );
              }
            },
          ),
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Intro survey completed! Sign out and your customized lesson plan will be ready when you sign in again!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
