
pragma solidity ^0.4.0;
contract Points {

    address chairperson;
    Client[] clients;
    Cashier[]  cashiers;

    struct Client {
        address address_client;
        uint points;
    }

    struct Cashier {
        address address_cashier;
    }
    
    function Points() {
        chairperson = msg.sender;
    }

    // Allow voters to vote, take in argument the proposal
    function isCashier()constant returns(bool isCashier)
    {
        for(uint i = 0; i< cashiers.length ; i++)
        {
            if(msg.sender == cashiers[i].address_cashier )
            {
                isCashier = true;
                return isCashier;
            }else{
                isCashier = false;
                return isCashier;
            }
        }
    }

    // Allow to add a new Client to the list, can only be performed by cashier
    function addClient(address client) {
        bool present = false;
        
        for(uint i = 0; i< clients.length ; i++)
        {
            if(client == clients[i].address_client)
            {
                present = true;
            }
        }
        if(present)throw;
        else{
                if(isCashier())
                {
                    clients.push(Client({address_client :client, points : 0}));
                }
                else{throw;}
            }
    }
    
    
    // Add a new Cashier in the list of Cashier, only can performed by chairperson 
    function addCashier(address cashier) {
        bool present = false;
        if (msg.sender != chairperson)
        {
            throw;
        }
        for(uint i = 0; i< cashiers.length ; i++)
        {
            if(cashier == cashiers[i].address_cashier)
            {
                present = true ;
            }
        }
        if(!present)
        {
            cashiers.push(Cashier({address_cashier : cashier}));
        }

    }
    // Allow to add a new proposal to proposals tab this operation can be only
    // perform by the chairman
    // Takes in parameter the name of the proposal
	
    function addPoint(address client, uint points) {
        if (isCashier() == true)
        {
            for(uint i  = 0 ; i < clients.length; i++)
            {
                if(clients[i].address_client == client)
                {
                    clients[i].points += points;
                }
            }
        }else throw;
    }
    
    
    function usePoint(address client, uint points) {
        if (isCashier() == true)
        {
           for(uint i  = 0 ; i < clients.length; i++)
            {
                if(clients[i].address_client == client)
                {
                    if(clients[i].points > points)
                    {
                        clients[i].points = clients[i].points - points;
                    }else{
                        
                        throw;
                    }
                    
                }
            }
        }else throw;
    }
    

    
    function kill() {
        if (msg.sender == chairperson) {
            suicide(chairperson);
        }else{ throw;}
    }
}