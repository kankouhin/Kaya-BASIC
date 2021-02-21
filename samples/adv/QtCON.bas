Option Explicit
Option Verbose
Option PlatForm QT
Option 64Bit On

Using QtCore.QCoreApplication
Using QtCore.QDebug

Using QtSql.QSqlDatabase
Using QtSql.QSqlQuery
Using QtSql.QSqlError

Sub createTable(ByRef db As QSqlDatabase)
        Dim query As QSqlQuery(db)
        If query.prepare("CREATE TABLE account(id INTEGER PRIMARY KEY, name TEXT NOT NULL, password TEXT NOT NULL)") Then
                If Not query.exec() Then
                        qWarning() << query.lastError()
                        qInfo() << query.lastQuery() << query.boundValues()
                End If
        Else
                qWarning() << query.lastError()
        End If
End Sub

Sub insertTable(ByRef db As QSqlDatabase)
        Dim query As QSqlQuery(db)
        If query.prepare("INSERT INTO account(name, password) VALUES (?, ?)") Then

                query.addBindValue("user0")
                query.addBindValue("password0")  ' TODO: do not store plain password

                If query.exec() Then
                        qInfo() << query.lastInsertId().toLongLong() << QString("added")
                Else
                        qWarning() << query.lastError()
                        qInfo() << query.lastQuery() << query.boundValues()
                End If
        Else
                qWarning() << query.lastError()
        End If
End Sub

Sub selectTable(ByRef db As QSqlDatabase)
        Dim query As QSqlQuery(db)
        If query.prepare("SELECT id, name, password FROM account") Then
                If query.exec() Then
                        while query.next()
                                Dim id As qlonglong = query.value(0).toLongLong()
                                Dim name As QString = query.value(1).toString()
                                Dim password As QString = query.value(2).toString()
                                qDebug() << id << name << password
                        Wend
                End If
        Else
                qWarning() << query.lastError()
        End If
End Sub

Sub Main
        Dim connectionName As QString("example")
        QSqlDatabase.addDatabase("QSQLITE", connectionName)

        Dim db As QSqlDatabase = QSqlDatabase.database(connectionName)
        db.setDatabaseName(":memory:")  ' or file path
        
        If ( Not db.open() ) Then
                qWarning() << db.lastError()
                Exit Sub
        End If

        Call createTable( db )
        
        Call insertTable( db )
        Call insertTable( db )
        Call insertTable( db )
        Call insertTable( db )

        Call selectTable( db )

        db.close()
End Sub