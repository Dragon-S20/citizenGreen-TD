import React from 'react'
import { Heading, VStack, HStack,Text, Center, Button, Input } from '@chakra-ui/core'
import { ethers } from 'ethers'
import { Web3Context } from './hooks/useWeb3'
import {
  Contact_address,
  Contact_abi,
} from './contracts/Citizens'


function App() {
  const [web3State, login] = useContext(Web3Context)
  const [entreprise, setEntreprise] = useState(null)
  const [inputName, setInputName] = useState('')
  const [inputSalary, setInputSalary] = useState('')
  

  const handleOnClickSaveEntreprise = async () => {
    await citizen.registerEntreprise ( inputName, inputSalary)
  }

  useEffect(() => {
    if (web3State.signer !== null) {
      setEntreprise(
        new ethers.Contract(
          Citizen_address,
          Citizen_abi,
          web3State.signer
        )
      )
    }
  }, [web3State.signer])

  return(
    <>
          <HStack>
            <Text>Créer une entreprise </Text>
            <Input
              value={inputValue}
              onChange={(e) => {
                setInputEntreprise(e.currentTarget.value)
              }}
            />
          </HStack>
    </>
  )
}

export default App
