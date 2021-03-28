 /*

-- This file is the one I Hand typed, Use "bookstore.sql" to import the database

CREATE DATABASE IF NOT EXISTS `bookstore`;

USE `bookstore`;

 CREATE TABLE IF NOT EXISTS `user_type` (
    `TYPE_ID` int(2) NOT NULL COMMENT 'Type ID, auto generated',
  `TYPE_NAME` varchar(255) NOT NULL COMMENT 'Type of User, 1 for Admin, 2 for Customer',
     PRIMARY KEY (`TYPE_ID`)
 );

 CREATE TABLE IF NOT EXISTS `user_status` (
     `STATUS_ID` int(2) NOT NULL COMMENT 'Status ID, auto generated',
  `STATUS_NAME` varchar(255) NOT NULL COMMENT 'Status of User', 
     PRIMARY KEY (`STATUS_ID`)
 );


CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email_address` varchar(45) NOT NULL,
  `enabled` bit(1) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `password` varchar(64) NOT NULL,
  `phonenumber` varchar(64) NOT NULL,
  `reset_password_token` varchar(255) DEFAULT NULL,
  `user_name` varchar(20) NOT NULL UNIQUE,
  `verification_code` varchar(64) DEFAULT NULL,
  `USER_STATUS` INT(2) DEFAULT 2,
  `USER_TYPE` INT(2) DEFAULT 2,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_1ar956vx8jufbghpyi09yr16l` (`email_address`)
  
);


CREATE TABLE IF NOT EXISTS `address` (
  `ADDRESS_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Address ID, Auto generated',
  `FIRST_NAME` varchar(255) NOT NULL COMMENT 'User First Name',
  `LAST_NAME` varchar(255) NOT NULL COMMENT 'User Last Name',
  `STREET` varchar(255) NOT NULL COMMENT 'Street of Address',
  `CITY` varchar(255) NOT NULL COMMENT 'City of Address',
  `STATE` varchar(255) NOT NULL COMMENT 'State of Address',
  `ZIP` int(5) NOT NULL COMMENT 'Zip Code of Address',
  `USER_ID` int(11) NOT NULL COMMENT 'User ID associated to the payment method',
  PRIMARY KEY (`ADDRESS_ID`), 
  FOREIGN KEY (`USER_ID`) REFERENCES `users` (`id`)
);


CREATE TABLE IF NOT EXISTS `payment_card` (
  `PAYMENT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Payment ID, auto generated',
  `CARD_NUM` bigint(16) NOT NULL COMMENT 'Card Number',
  `USER_ID` int(11) NOT NULL COMMENT 'User ID associated to the payment method',
  `BILLING_ADDRESS` int(11) NOT NULL COMMENT 'Billing Address for the payment method',
  `TYPE` varchar(255) NOT NULL COMMENT 'Type of Card Payment',
  `EXP_DATE` date NOT NULL COMMENT 'Expiration Date for Card',
  `CVV` int(3) NOT NULL COMMENT 'Card Verification Value',
    PRIMARY KEY (`PAYMENT_ID`), 
    FOREIGN KEY (`USER_ID`) REFERENCES `users` (`id`),
    FOREIGN KEY (`BILLING_ADDRESS`) REFERENCES `address` (`ADDRESS_ID`)
);


CREATE TABLE IF NOT EXISTS `book` (
  `BOOK_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Book ID, Auto generated',
  `TITLE` varchar(255) NOT NULL COMMENT 'Title of Book',
  `ISBN` varchar(13) NOT NULL COMMENT '(International Standard Book Number). A unique 13 digit identifier given to each edition of a book',
  `AUTHOR_NAME` varchar(255) NOT NULL COMMENT 'Name of Author of Book',
  `CATEGORIES` varchar(255) DEFAULT NULL COMMENT 'Category of Book',
  `DESCRIPTION` varchar(1000) NOT NULL COMMENT 'Description of Book',
  `COVER_PICTURE` varchar(255) NOT NULL COMMENT 'Cover Image of Book',
  `EDITION` int(11) NOT NULL COMMENT 'Edition of Book',
  `PUBLISHER_NAME` varchar(50) NOT NULL COMMENT 'Name of Publisher of Book',
  `PUBLISHER_YEAR` varchar(50) NOT NULL COMMENT 'Publisher Year of Book',
  `PRICE` double(10,2) NOT NULL COMMENT 'Price of Book',
  `QUANTITY` int(11) NOT NULL COMMENT 'Amount of Books in the system',
  `KEYWORDS` varchar(255) DEFAULT NULL COMMENT 'Keywords related to the book',
  `STATUS` int(11) DEFAULT NULL COMMENT 'Status of book',
  `QUANTITY_ON_HAND` int(11) DEFAULT NULL,
  `MINIMUM_THRESHOLD` int(11) DEFAULT NULL,
    PRIMARY KEY (`BOOK_ID`)
);


-- CREATE TABLE IF NOT EXISTS `inventory_book` (
--     `INV_BOOK_ID` int(11) NOT NULL AUTO_INCREMENT,
--     `BOOK_ID` int(11) NOT NULL,
--     `QUANTITY_ON_HAND` INT(11) NOT NULL,
--     `STATUS` INT(11) NOT NULL,
--     `PRICE` DOUBLE(10, 2) NOT NULL,
--     PRIMARY KEY (`INV_BOOK_ID`),
--     FOREIGN KEY (`BOOK_ID`) REFERENCES `book` (`BOOK_ID`)
-- );



CREATE TABLE IF NOT EXISTS `cart` (
    `CART_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Cart ID, Auto generated',
    `USER_ID` int(11) NOT NULL COMMENT 'User ID that is associated to the cart',
    PRIMARY KEY (`CART_ID`), 
    FOREIGN KEY (`USER_ID`) REFERENCES `users` (`id`)
);


CREATE TABLE IF NOT EXISTS `cart_item` (
  `CART_ID` int(11) NOT NULL COMMENT 'Cart ID that is associated to the book in cart',
  `BOOK_ID` int(11) NOT NULL COMMENT 'Book ID that is associated to the cart item',
  `QUANTITY` int(11) NOT NULL COMMENT 'Amount of item for the given cart item',
    FOREIGN KEY (`CART_ID`) REFERENCES `cart` (`CART_ID`),
    FOREIGN KEY (`BOOK_ID`) REFERENCES `book` (`BOOK_ID`)
);




CREATE TABLE IF NOT EXISTS `promotion` (
  `PROMO_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Promo ID, auto generated',
  `START_DATE` date NOT NULL COMMENT 'Promotion Start Date',
  `END_DATE` date NOT NULL COMMENT 'Promotion End Date',
  `DISCOUNT` double(10,2) NOT NULL COMMENT 'Amount of Discount for Promotion',
    PRIMARY KEY (`PROMO_ID`)
);


CREATE TABLE IF NOT EXISTS `shipping_type` (
  `SHIPPING_ID` int(11) NOT NULL COMMENT 'Shipping ID, auto generated',
  `SHIPPING_NAME` varchar(255) NOT NULL COMMENT 'Shipping Method Name',
  `SHIPPING_COST` double(10,2) NOT NULL COMMENT 'Cost of Shipping Method',
  `SHIPPING_SPEED` varchar(255) NOT NULL COMMENT 'Speed for Shipping Method',
    PRIMARY KEY (`SHIPPING_ID`)
);


CREATE TABLE IF NOT EXISTS `order` (
  `ORDER_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Order ID, auto generated',
  `USER_ID` int(11) NOT NULL COMMENT 'User ID that is associated to the order',
  `PAYMENT_ID` int(11) NOT NULL COMMENT 'Payment ID that is associated to the order',
  `SUBTOTAL` double(10,2) NOT NULL COMMENT 'The amount of the order before taxes',
  `TOTAL_TAX` double(10,2) NOT NULL COMMENT 'The tax calculated based on the sub total of the order',
  `GRAND_TOTAL` double(10,2) NOT NULL COMMENT 'The total of the order including taxes',
  `PROMO_ID` int(11) NOT NULL COMMENT 'Promo ID that is associated to the order',
  `ORDER_DATE_TIME` datetime NOT NULL COMMENT 'The data and time of the order',
  `SHIPPING_TYPE` int(11) NOT NULL COMMENT 'The type of shipping that is associated to the order',
    PRIMARY KEY (`ORDER_ID`), 
    FOREIGN KEY (`USER_ID`) REFERENCES `users` (`id`),
    FOREIGN KEY (`PAYMENT_ID`) REFERENCES `payment_card` (`PAYMENT_ID`),
    FOREIGN KEY (`PROMO_ID`) REFERENCES `promotion` (`PROMO_ID`),
    FOREIGN KEY (`SHIPPING_TYPE`) REFERENCES `shipping_type` (`SHIPPING_ID`)
);


CREATE TABLE IF NOT EXISTS `order_item` (
   `ORDER_ID` int(11) NOT NULL COMMENT 'Order ID, auto generated',
  `BOOK_ID` int(11) NOT NULL COMMENT 'Book ID associated to the order item',
  `QUANTITY` int(11) NOT NULL COMMENT 'Amount of Book for given item',
    FOREIGN KEY (`ORDER_ID`) REFERENCES `order` (`ORDER_ID`),
    FOREIGN KEY (`BOOK_ID`) REFERENCES `book` (`BOOK_ID`)
);



 -- These are example values for the different type tables 

INSERT INTO `user_type` (`TYPE_ID`, `TYPE_NAME`) VALUES 
(1, "Admin"), 
(2, "Customer");


INSERT INTO `user_status` (`STATUS_ID`, `STATUS_NAME`) VALUES 
(1, "Inactive/Unregistered"), 
(2, "Active/Registered"), 
(3, "Suspended");


INSERT INTO `shipping_type`(`SHIPPING_ID`, `SHIPPING_NAME`, `SHIPPING_COST`, `SHIPPING_SPEED`) VALUES 
(1, "Standard Shipping", 4.99, "3-5 Business Days"), 
(2, "Express Shipping", 7.99, "2-3 Business Days"), 
(3, "Expedited Shipping", 15.99, "1-2 Business Days");


INSERT INTO `users`(`email_address`, `enabled`, `first_name`, `last_name`, `password`, `phonenumber`, `reset_password_token`, `user_name`, `verification_code`) VALUES 
('jorrinthacker1@gmail.com',_binary '','Jorrin','Thacker','$2a$10$5yhD1FqT84nk2nd0ft6tDeigWJeukblWYUj1z.wrw4DXW2NFQ.EC6','7063087444','O6cLe291cvnKzCNxADdzJaa2H4HW27GmZM8U50YC65mVJ','jorrinct','JBU7aIgvE4rku71kwa47d3aELA2tdhYI4IGq9Dv0y9St37T4gI67JUqcPUrlx1Bv');


INSERT INTO `book`(`TITLE`, `ISBN`, `AUTHOR_NAME`, `CATEGORIES`, `DESCRIPTION`, `COVER_PICTURE`, `EDITION`, `PUBLISHER_NAME`, `PUBLISHER_YEAR`, `PRICE`, `QUANTITY`) VALUES 
-- ("TITLE", "6784831248962", "AUTHOR", "CATEGORY", "DESCRIPTION", "PICTURE", 1, "PUBL_NAME", "0000", 0.00, 0);
-- ("151 Days of CSCI 4050", "8295622803047", "Team B1", "Novel", "This work details the adventures of a semester of Object-Oriented Design and teamwork. In this course you will study the principles of Software Engineering, focusing on Object-Oriented Software Engineering. We will begin with the introductory discussion of the software development process and what constitutes well-engineered software. Then we will move on to software specification and requirements definition. The next part of the course will be devoted to software design. Although we will discuss some of the major design techniques, we will specifically concentrate on Object-Oriented Design (OOD). A significant portion of the course will be dedicated to learning the Unified Modeling Language (UML). :)", "https://tiffyxsammy.github.io/bookstore/assets/img/151days.jpg", 1, "Team B1", 2021, 20.21, 4),
("The Great Gatsby", "6813826420908", "F. Scott Fitzgerald",  "Novel, Tragedy, Literary fiction,", "Midwest native Nick Carraway (Tobey Maguire) arrives in 1922 New York in search of the American dream. Nick, a would-be writer, moves in next-door to millionaire Jay Gatsby (Leonardo DiCaprio) and across the bay from his cousin Daisy (Carey Mulligan) and her philandering husband, Tom (Joel Edgerton). Thus, Nick becomes drawn into the captivating world of the wealthy and -- as he bears witness to their illusions and deceits -- pens a tale of impossible love, dreams, and tragedy.", "https://tiffyxsammy.github.io/bookstore/assets/img/greatgats.jpg", 1, "Charles Scribner's Sons", "1925", 19.24, 5),
("Les Misérables", "5618782952038", "Victor Hugo", "Novel, Historical Fiction, Tragedy, Epic", "The convict Jean Valjean is released from a French prison after serving nineteen years for stealing a loaf of bread and for subsequent attempts to escape from prison. When Valjean arrives at the town of Digne, no one is willing to give him shelter because he is an ex-convict. Desperate, Valjean knocks on the door of M. Myriel, the kindly bishop of Digne. Myriel treats Valjean with kindness, and Valjean repays the bishop by stealing his silverware. When the police arrest Valjean, Myriel covers for him, claiming that the silverware was a gift. The authorities release Valjean and Myriel makes him promise to become an honest man. Eager to fulfill his promise, Valjean masks his identity and enters the town of Montreuil-sur-mer. Under the assumed name of Madeleine, Valjean invents an ingenious manufacturing process that brings the town prosperity. He eventually becomes the town’s mayor.", "https://tiffyxsammy.github.io/bookstore/assets/img/lesmis.jpg", 1, "Albert Lacroix", "1862", 246.01, 3),
("Julius Caesar", "4506818224793", "William Shakespeare", "Play, Historical Fiction, Tragedy,", "Two tribunes, Flavius and Murellus, find scores of Roman citizens wandering the streets, neglecting their work in order to watch Julius Caesar’s triumphal parade: Caesar has defeated the sons of the deceased Roman general Pompey, his archrival, in battle. The tribunes scold the citizens for abandoning their duties and remove decorations from Caesar’s statues. Caesar enters with his entourage, including the military and political figures Brutus, Cassius, and Antony. A Soothsayer calls out to Caesar to “beware the Ides of March,” but Caesar ignores him and proceeds with his victory celebration (I.ii.19, I.ii.25).", "https://tiffyxsammy.github.io/bookstore/assets/img/juliusc.jpg", 1, "Simon & Schuster", "1599", 15.99, 14),
("Romeo and Juliet", "3259628779283", "William Shakespeare", "Play, Historical Fiction, Tragedy,", "In the streets of Verona another brawl breaks out between the servants of the feuding noble families of Capulet and Montague. Benvolio, a Montague, tries to stop the fighting, but is himself embroiled when the rash Capulet, Tybalt, arrives on the scene. After citizens outraged by the constant violence beat back the warring factions, Prince Escalus, the ruler of Verona, attempts to prevent any further conflicts between the families by decreeing death for any individual who disturbs the peace in the future. Romeo, the son of Montague, runs into his cousin Benvolio, who had earlier seen Romeo moping in a grove of sycamores. After some prodding by Benvolio, Romeo confides that he is in love with Rosaline, a woman who does not return his affections.", "https://tiffyxsammy.github.io/bookstore/assets/img/romeo.jpg", 1, "Simon & Schuster", "1597", 15.97, 13),
("The Tragedy of Macbeth", "2418532312271", "William Shakespeare", "Play, Historical Fiction, Tragedy,", "The play begins with the brief appearance of a trio of witches and then moves to a military camp, where the Scottish King Duncan hears the news that his generals, Macbeth and Banquo, have defeated two separate invading armies—one from Ireland, led by the rebel Macdonwald, and one from Norway. Following their pitched battle with these enemy forces, Macbeth and Banquo encounter the witches as they cross a moor. The witches prophesy that Macbeth will be made thane (a rank of Scottish nobility) of Cawdor and eventually King of Scotland.", "https://tiffyxsammy.github.io/bookstore/assets/img/macbeth.jpg", 1, "Simon & Schuster", "1623", 16.23, 16),
("Letters of Emily Dickinson", "9451006855965", "Emily Dickinson", "Poetry", "The Letter’ by Emily Dickinson depicts the surge of emotions in the speaker’s heart while she writes a letter to her lover. In the poem, the poetic persona starts to talk with the letter which she has finished a while ago. She treats the letter not as an object. It seems to be one of her companions. The speaker feels happy as the letter is going to meet her beloved. The speaker urges the letter to tell her lover how she struggled with words while writing the letter. She wants to share her feelings to the person for whom the letter is written. If there are any mistakes from her side, she wishes the letter must defend her.", "https://tiffyxsammy.github.io/bookstore/assets/img/dickinson.jpg", 1, "Emily Dickenson", "1894", 18.62, 5),
("Hamlet", "8298049142570", "William Shakespeare", "Play, Historical Fiction, Tragedy,", "On a dark winter night, a ghost walks the ramparts of Elsinore Castle in Denmark. Discovered first by a pair of watchmen, then by the scholar Horatio, the ghost resembles the recently deceased King Hamlet, whose brother Claudius has inherited the throne and married the king’s widow, Queen Gertrude. When Horatio and the watchmen bring Prince Hamlet, the son of Gertrude and the dead king, to see the ghost, it speaks to him, declaring ominously that it is indeed his father’s spirit, and that he was murdered by none other than Claudius. Ordering Hamlet to seek revenge on the man who usurped his throne and married his wife, the ghost disappears with the dawn.", "https://tiffyxsammy.github.io/bookstore/assets/img/hamlet.jpg", 1, "Simon & Schuster", "1609", 16.09, 6),
("Lord of the Flies", "1434416796981", "William Golding", "Novel, Allegory, Young adult fiction, Psychological Fiction", "At the dawn of the next world war, a plane crashes on an uncharted island, stranding a group of schoolboys. At first, with no adult supervision, their freedom is something to celebrate. This far from civilization they can do anything they want. Anything. But as order collapses, as strange howls echo in the night, as terror begins its reign, the hope of adventure seems as far removed from reality as the hope of being rescued.", "https://images-na.ssl-images-amazon.com/images/I/51eeAWItwbL._SX281_BO1,204,203,200_.jpg", 1, "Penguine Books", "1954", 19.54, 7),
("Charlotte's Web", "6784831248962", "E. B. White", "Children's literature, Novel, Quotation, Fiction", "Some Pig. Humble. Radiant. These are the words in Charlotte's Web, high up in Zuckerman's barn. Charlotte's spiderweb tells of her feelings for a little pig named Wilbur, who simply wants a friend. They also express the love of a girl named Fern, who saved Wilbur's life when he was born the runt of his litter. E. B. White's Newbery Honor Book is a tender novel of friendship, love, life, and death that will continue to be enjoyed by generations to come. It contains illustrations by Garth Williams, the acclaimed illustrator of E. B. White's Stuart Little and Laura Ingalls Wilder's Little House series, among many other books.", "https://images-na.ssl-images-amazon.com/images/I/71shFGSgj0L.jpg", 1, "Harper", "1952", 19.52, 9),
("A Tale of Two Cities", "2585447983183", "Charles Dickens", "Historical Fiction", "A Tale of Two Cities (1859) is a novel by Charles Dickens, set in London and Paris before and during the French Revolution. The novel depicts the plight of the French peasantry demoralised by the French aristocracy in the years leading up to the revolution, the corresponding brutality demonstrated by the revolutionaries toward the former aristocrats in the early years of the revolution, and many unflattering social parallels with life in London during the same period. It follows the lives of several characters through these events. A Tale of Two Cities was published in weekly instalments from April 1859 to November 1859 in Dickens's new literary periodical titled All the Year Round. All but three of Dickens's previous novels had appeared only as monthly installments.", "https://images-na.ssl-images-amazon.com/images/I/81hKPqaR-BL.jpg", 1, "Chapman & Hall", "1775", 17.75, 11),
("Alice's Adventures in Wonderland", "9339213489815", "Lewis Carroll", "Fairy tale, Novel, Children's literature, Fantasy Fiction, Literary nonsense, Absurdist fiction, Fantastique", "Alice's Adventures in Wonderland is an 1865 novel written by English author Charles Lutwidge Dodgson under the pseudonym Lewis Carroll. It tells of a girl named Alice falling through a rabbit hole into a fantasy world populated by peculiar, anthropomorphic creatures. The tale plays with logic, giving the story lasting popularity with adults as well as with children. It is considered to be one of the best examples of the literary nonsense genre. Its narrative course and structure, characters and imagery have been enormously influential in both popular culture and literature, especially in the fantasy genre.", "https://images-na.ssl-images-amazon.com/images/I/71su1O1yFJL.jpg", 1, "Macmillan Publishers", "1865", 18.65, 6),
("Animal Farm", "9660947691145", "George Orwell", "Novel, Satire, Allegory, Roman à clef, Political satire, Dystopian Fiction", "A farm is taken over by its overworked, mistreated animals. With flaming idealism and stirring slogans, they set out to create a paradise of progress, justice, and equality. Thus the stage is set for one of the most telling satiric fables ever penned—a razor-edged fairy tale for grown-ups that records the evolution from revolution against tyranny to a totalitarianism just as terrible.", "https://images-na.ssl-images-amazon.com/images/I/71wdbkiRokL.jpg", 1, "Plume ", "1945", 19.45, 2),
("To Kill a Mockingbird", "8795976851221", "Harper Lee", " Novel, Historical Fiction, Bildungsroman, Thriller, Southern Gothic, Domestic Fiction, Legal Story, Didactic fiction", "One of the most cherished stories of all time, To Kill a Mockingbird has been translated into more than forty languages, sold more than forty million copies worldwide, served as the basis for an enormously popular motion picture, and was voted one of the best novels of the twentieth century by librarians across the country. A gripping, heart-wrenching, and wholly remarkable tale of coming-of-age in a South poisoned by virulent prejudice, it views a world of great beauty and savage inequities through the eyes of a young girl, as her father—a crusading local lawyer—risks everything to defend a black man unjustly accused of a terrible crime.", "https://images-na.ssl-images-amazon.com/images/I/81aY1lxk+9L.jpg", 1, "J. B. Lippincott & Co.", "1960", 19.60, 8),
("Of Mice and Men", "2612442619001", "John Steinbeck", "Fiction, Novella, Tragedy", "They are an unlikely pair: George is 'small and quick and dark of face'; Lennie, a man of tremendous size, has the mind of a young child. Yet they have formed a 'family,' clinging together in the face of loneliness and alienation. Laborers in California's dusty vegetable fields, they hustle work when they can, living a hand-to-mouth existence. For George and Lennie have a plan: to own an acre of land and a shack they can call their own. When they land jobs on a ranch in the Salinas Valley, the fulfillment of their dream seems to be within their grasp. But even George cannot guard Lennie from the provocations of a flirtatious woman, nor predict the consequences of Lennie's unswerving obedience to the things George taught him.", "https://images-na.ssl-images-amazon.com/images/I/71H0EUnl5QL.jpg", 1, "Pascal Covici", "1937", 19.37, 18),
("Little Women", "1690550620256", "Little Women", "Novel, Fiction, Children's literature, Comedy, Bildungsroman", "Little Women follows the lives of the four March sisters—Meg, Jo, Beth, and Amy—and details their passage from childhood to womanhood. It is loosely based on the lives of the author and her three sisters. Little Women was an immediate commercial and critical success. The novel addresses three major themes: 'domesticity, work, and true love, all of them interdependent and each necessary to the achievement of its heroine's individual identity.' According to literary historian Sarah Elbert, Alcott created a new form of literature, one that took elements from Romantic children's fiction and combined it with others from sentimental novels, resulting in a totally new format. Elbert argues that within Little Women can be found the first vision of the 'All-American girl' and that her various aspects are embodied in the differing March sisters.", "https://images-na.ssl-images-amazon.com/images/I/71eAXvgIrFL.jpg", 1, "Roberts Brothers", "1868", 18.68, 16),
("Oliver Twist", "3012121763094", "Charles Dickens", "Novel, ", "Oliver Twist; or, the Parish Boy's Progress is Charles Dickens's second novel, and was first published as a serial from 1837 to 1839. The story centres on orphan Oliver Twist, born in a workhouse and sold into apprenticeship with an undertaker. After escaping, Oliver travels to London, where he meets the 'Artful Dodger', a member of a gang of juvenile pickpockets led by the elderly criminal Fagin. Oliver Twist is notable for its unromantic portrayal of criminals and their sordid lives, as well as for exposing the cruel treatment of the many orphans in London in the mid-19th century. In this early example of the social novel, Dickens satirises the hypocrisies of his time, including child labour, the recruitment of children as criminals, and the presence of street children. ", "https://images-na.ssl-images-amazon.com/images/I/916LksNztcL.jpg", 1, "Richard Bentley", "1838", 18.38, 12),
("Frankenstein", "6595123972734", "Mary Shelley", "Gothic fiction, Science Fiction, Horror fiction, Romance novel, Soft science fiction", "Few creatures of horror have seized readers' imaginations and held them for so long as the anguished monster of Mary Shelley's Frankenstein. The story of Victor Frankenstein's terrible creation and the havoc it caused has enthralled generations of readers and inspired countless writers of horror and suspense. Considering the novel's enduring success, it is remarkable that it began merely as a whim of Lord Byron's. 'We will each write a story,' Byron announced to his next-door neighbors, Mary Wollstonecraft Godwin and her lover Percy Bysshe Shelley. The friends were summering on the shores of Lake Geneva in Switzerland in 1816, Shelley still unknown as a poet and Byron writing the third canto of Childe Harold. When continued rains kept them confined indoors, all agreed to Byron's proposal.", "https://images-na.ssl-images-amazon.com/images/I/51KTgDVefPL._SX372_BO1,204,203,200_.jpg", 1, "Lackington, Hughes, Harding, Mavor, & Jones", "1823", 18.23, 17),
("The Scarlet Letter", "4731357997865", "Nathaniel Hawthorne", "Novel, Romance novel, Historical Fiction, historical novel, Reference work", "An 'A' for 'adultery' marks Hester Prynne as an outcast from the society of colonial Boston. Although forced by the puritanical town fathers to wear a bright red badge of shame, Hester steadfastly resists their efforts to discover the identity of her baby's father. The return of her long-absent spouse brings new pressure on the young mother, as the aggrieved husband undertakes a long-term plot to reveal Hester's partner in adultery and force him to share her disgrace. Masterful in its symbolism and compelling in its character studies, Nathaniel Hawthorne's tale of punishment and reconciliation examines the concepts of sin, guilt, and pride. The Scarlet Letter was published to immediate acclaim in 1850. Its timeless exploration of moral and spiritual issues, along with its philosophical and psychological insights, keep it ever relevant for students of American literature and lovers of fiction.", "https://m.media-amazon.com/images/I/41isnatQYrL.jpg", 1, "Ticknor and Fields", "1850", 18.50, 16),
("The Call of the Wild", "6085735570947", "Jack London", "Novel, Adventure fiction, Young Adult Fiction, Drama, Fantasy Fiction, ", "The Call of the Wild is a novel by Jack London published in 1903. The story is set in the Yukon during the 1890s Klondike Gold Rush—a period when strong sled dogs were in high demand. The novel's central character is a dog named Buck, a domesticated dog living at a ranch in the Santa Clara valley of California as the story opens. Stolen from his home and sold into the brutal existence of an Alaskan sled dog, he reverts to atavistic traits. Buck is forced to adjust to, and survive, cruel treatments and fight to dominate other dogs in a harsh climate. Eventually he sheds the veneer of civilization, relying on primordial instincts and lessons he learns, to emerge as a leader in the wild.London lived for most of a year in the Yukon collecting material for the book. The story was serialized in the Saturday Evening Post in the summer of 1903; a month later it was released in book form. ", "https://images-na.ssl-images-amazon.com/images/I/41AfuOFtXsL.jpg", 1, "Macmillan Inc.", "1903", 19.03, 15),
("Anne of Green Gables", "8968824464077", "Lucy Maud Montgomery", " Novel, Children's literature, Fiction, Bildungsroman", "Eleven-year-old Anne Shirley has never known a real home. Since her parents' deaths, she's bounced around to foster homes and orphanages. When she is sent by mistake to live with Matthew and Marilla Cuthbert at the snug white farmhouse called Green Gables, she wants to stay forever. But Anne is not the sturdy boy Matthew and Marilla were expecting. She's a mischievous, talkative redheaded girl with a fierce temper, who tumbles into one scrape after another. Anne is not like anybody else, the Cuthberts agree; she is special, a girl with an enormous imagination. All she's ever wanted is to belong somewhere. And the longer she stays at Green Gables, the harder it is for anyone to imagine life without her.", "https://images-na.ssl-images-amazon.com/images/I/41LTP-l5n4L.jpg", 1, "Louis Coues Page", "1908", 19.08, 6);

*/



