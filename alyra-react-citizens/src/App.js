import React, { useContext, useState, useEffect } from 'react'
import { Box, Heading, Text, Button, VStack, HStack, Input,FormControl,
  FormLabel,
  FormErrorMessage,
  FormHelperText } from '@chakra-ui/core'
import { ethers } from 'ethers'
import { Web3Context } from './hooks/useWeb3'
import {
  Citizen_address,
  Citizen_abi,
} from './contracts/Citizens'

function App() {
  const web3State = useContext(Web3Context)
  const [citizen, setCitizen] = useState(null)
  const [getValue, setGetValue] = useState(0)
  const [inputValue, setInputValue] = useState(0)
  const [inputAddr, setInputAddr] = useState('')
  const [inputName, setInputName] = useState('')
  const [inputEmployee, setInputEmployee] = useState(0)

  

  /*const handleOnClickSaveEntreprise = async () => {
    await citizen.setContact ( inputAddr, inputEmployee)
  }
  
  */
  useEffect(() => {
    if (web3State.signer !== null) {
      setCitizen(
        new ethers.Contract(
          Citizen_address,
          Citizen_abi,
          web3State.signer
        )
      )
    }
  }, [web3State.signer])

  // web3State.is_web3 ??
  // web3State.is_logged ??
  // web3State.chain_id ??
  // web3Sate.account && provider et signer

  return (
    <>
    <VStack>
    <Box  spacing={30} bg="tomato" w="100%" p={4} color="white">
      <VStack>
      <Text>Web3: {web3State.is_web3 ? 'injected' : 'no-injected'}</Text>
      <Text>Network id: {web3State.chain_id}</Text>
      <Text>Network name: {web3State.network_name}</Text>
      <Text>MetaMask installed: {web3State.is_metamask ? 'yes' : 'no'}</Text>
      <Text>logged: {web3State.is_logged ? 'yes' : 'no'}</Text>
      <Text>{web3State.account}</Text>
      </VStack>
      </Box>
      {!web3State.is_logged && (
        <>
          <Button onClick={web3State.login}>login</Button>
        </>
      )}
    
      {citizen !== null && web3State.chain_id === 4 && (
        <>
        <Heading>Bienvenue dans la société verte</Heading>
        <VStack>
        <FormControl isRequired>
    <FormLabel htmlFor="fname">Nom Entreprise</FormLabel>
    <Input id="faddr" placeholder="Adresse" value={inputValue}
                onChange={(e) => {
                  setInputAddr(e.currentTarget.value)
                }}/>
    <Input id="fname" placeholder="Nom entreprise" value={inputValue}
                onChange={(e) => {
                  setInputName(e.currentTarget.value)
                }}/>
              
    <Input id="femployee" placeholder="Nombre d'employés"value={inputValue}
                onChange={(e) => {
                  setInputEmployee(e.currentTarget.value)
                }} />
  
  </FormControl>
        <Button
          colorScheme="purple"
          color="red.400"
         /* onClick={handleOnClickSaveEntreprise}*/
        >
          Enregistrer l'entreprise 
        </Button>
              </VStack>
              </>
      )}
    </VStack>
  </>)
}

export default App