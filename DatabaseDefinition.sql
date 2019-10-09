CREATE DATABASE Portfolio;
USE Portfolio;

-- ###########################################################################

CREATE TABLE User (
	UserID INT PRIMARY KEY AUTO_INCREMENT,
	Username VARCHAR(50) UNIQUE NOT NULL,
	Password VARCHAR(50),
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50)
);

CREATE TABLE Shares (
	Symbol VARCHAR(50) PRIMARY KEY,
	ShareName VARCHAR(100) NOT NULL,
	Information VARCHAR(2000)
);

-- ###########################################################################

CREATE TABLE ShareHistory (
	TimeLog TIMESTAMP,
	ShareSymbol VARCHAR(50) REFERENCES Shares(Symbol) ON DELETE CASCADE ON UPDATE CASCADE,
	Price FLOAT(7, 2) NOT NULL CHECK (CurrentPrice > 0),
	CONSTRAINT primeKey PRIMARY KEY (ShareSymbol, TimeLog)
);

CREATE TABLE WatchList (
	UserID INT REFERENCES User(UserID) ON DELETE CASCADE ON UPDATE CASCADE,
	ShareSymbol VARCHAR(50) REFERENCES Shares(Symbol) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT primeKey PRIMARY KEY (UserID, ShareSymbol)
);

CREATE TABLE BuyShare (
	TimeLog TIMESTAMP,
	UserID INT REFERENCES User(UserID) ON DELETE CASCADE ON UPDATE CASCADE,
	Quantity INT CHECK (Quantity > 0),
	Price FLOAT,
	ShareSymbol VARCHAR(50) REFERENCES Shares(Symbol) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT primeKey PRIMARY KEY (UserID, TimeLog)
);

CREATE TABLE SellShare (
	TimeLog TIMESTAMP,
	UserID INT REFERENCES User(UserID) ON DELETE CASCADE ON UPDATE CASCADE,
	Quantity INT CHECK (Quantity > 0),
	Price FLOAT,
	ShareSymbol VARCHAR(50) REFERENCES Shares(Symbol) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT primeKey PRIMARY KEY (UserID, TimeLog)
);

-- BuySellFlag = 0 => Buy
-- BuySellFlag = 1 => Sell
CREATE TABLE UserHistory (
	UserID INT REFERENCES User(UserID) ON DELETE CASCADE ON UPDATE CASCADE,
	Quantity INT CHECK (Quantity > 0),
	TimeLog TIMESTAMP,
	Price FLOAT NOT NULL,
	BuySellFlag INT CHECK (BuySellFlag = 0 OR BuySellFlag = 1),
	ShareSymbol VARCHAR(50) REFERENCES Shares(Symbol) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT primeKey PRIMARY KEY (UserID, TimeLog)
);

-- ###########################################################################
-- Deleting all tables

-- DROP TABLE User;
-- DROP TABLE Shares;
-- DROP TABLE Currency;
-- DROP TABLE ShareHistory;
-- DROP TABLE WatchList;
-- DROP TABLE BuyShare;
-- DROP TABLE SellShare;
-- DROP TABLE UserHistory;