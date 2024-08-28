#include <iostream>
using namespace std;
char arr[12] = {'+', '-', '*', '/', '=', '(', ')', '{', '}', '<', '>', ';'};
// string token[5] = {"NUM", "IDENTIFIER", "SYMBOL", "KEYWORD", "Invalid"};

// [A-Za-z] [A-Za-z0-9_]*
bool TempIdChar_is_valid(int n, char ch) {
    int num = int(ch);
    if (!n) {
        if ((65 <= num && num <= 90) || (97 <= num && num <= 122))
            return true;
    } 
    else if (n) {
        if ((65 <= num && num <= 90) || (97 <= num && num <= 122) || num == 95 || (48 <= num && num <= 57))
            return true;
    }
    return false;
}

int main() 
{
    string line;
    while (getline(cin, line)) {
        // int id_is_valid = 1;
        if (line == "\t" || line == "\n" || line == " ")
            continue;
        int len = line.length();
        for (int i = 0; i < len; i++) {
            // cout << line[i] << endl;
            int is_symbol = 0;
            if (line[i] == ' ' || line[i] == '\t')
                continue;
            char ch = line[i];

            if (ch == '+' || ch == '-' || ch == '*' || ch == '/' || ch == '=' ||
                ch == '(' || ch == ')' || ch == '{' || ch == '}' || ch == '<' ||
                ch == '>' || ch == ';') {
                cout << "SYMBOL " << '\"' << ch << '\"' << endl;;
                is_symbol = 1;
            }

            if (is_symbol)
                continue;
            else {
                int num = int(ch);
                // NUM
                if (48 <= num && num <= 57) {
                    string temp = "";
                    temp += ch;
                    while (i + 1 < len) {
                        if (line[i+1] == ' ') {
                            break;
                        }
                        if (line[i+1] == '+' || line[i+1] == '-' || line[i+1] == '*' ||
                            line[i+1] == '/' || line[i+1] == '=' || line[i+1] == '(' ||
                            line[i+1] == ')' || line[i+1] == '{' || line[i+1] == '}' ||
                            line[i+1] == '<' || line[i+1] == '>' || line[i+1] == ';') {
                                break;
                        }
                        if (48 <= line[i+1] && line[i+1] <= 57) {
                            temp += line[i + 1];
                        }
                        else break;
                        i++;
                    }
                    // while (isdigit(line[i+1])) {
                    //     temp += line[i+1];
                    //     i++;
                    // }
                    if (temp.length() == 1) {
                        cout << "NUM " << '\"' << temp << '\"' << endl;
                    } 
                    else {
                        int Len = temp.length();
                        for (int k = 0; k < Len; k++) {
                            if (temp[k] - 48 == 0) cout << "NUM " << '\"' << 0 << '\"' << endl;
                            else {
                                cout << "NUM " << '\"' << temp.substr(k) << '\"' << endl;
                                break;
                            }
                        }
                    }
                }
                // ID
                else if ((65 <= num && num <= 90) || (97 <= num && num <= 122)) {
                    string id = "";
                    while (true) {
                        if (i >= len) {
                            if (id == "if" || id == "else" || id == "while")
                                cout << "KEYWORD " << '\"' << id << '\"' << endl;
                            else
                                cout << "IDENTIFIER " << '\"' << id << '\"' << endl;
                            break;
                        }
                        int L = id.length();
                        ch = line[i];
                        if (ch == ' ') {
                            if (id == "if" || id == "else" || id == "while")
                                cout << "KEYWORD " << '\"' << id << '\"' << endl;
                            else
                                cout << "IDENTIFIER " << '\"' << id << '\"' << endl;
                            i--;
                            break;
                        }
                        if (TempIdChar_is_valid(L, ch)) {
                            id += ch;
                        } 
                        else {
                            if (ch == '+' || ch == '-' || ch == '*' ||
                                ch == '/' || ch == '=' || ch == '(' ||
                                ch == ')' || ch == '{' || ch == '}' ||
                                ch == '<' || ch == '>' || ch == ';') {
                                i--;
                                if (id == "if" || id == "else" || id == "while")
                                    cout << "KEYWORD " << '\"' << id << '\"' << endl;
                                else
                                    cout << "IDENTIFIER " << '\"' << id << '\"' << endl;
                            } 
                            else {
                                // id_is_valid = 0;
                                // e.g. abc?
                                cout << "IDENTIFIER " << '\"' << id << '\"' << endl;
                                i--;
                            }
                            break;
                        }
                        i++;
                    }
                } 
                else {
                    cout << "Invalid" << endl;
                }
            }
        }

    }
    return 0;
}
